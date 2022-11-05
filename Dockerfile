FROM alpine:3.16.2

RUN apk add bash curl grep openssl openvpn cpio uuidgen openrc jq
WORKDIR /root
CMD [ -z "$EVON_DEPLOY_KEY" ] && echo "ERROR: You must define environment variable EVON_DEPLOY_KEY to start this container." && exit 1 || \
    [ -z "$ACCOUNT_DOMAIN" ] && echo "ERROR: You must define environment variable ACCOUNT_DOMAIN to start this container." && exit 1 || \
    [ "${EXTRA_ARGS}" ] && extra_args="${EXTRA_ARGS} " || : && \
    [ "${EVON_HOSTNAME}" ] && extra_args="${extra_args} --hostname ${EVON_HOSTNAME} " || : && \
    [ "${EVON_UUID}" ] && extra_args="${extra_args} --uuid ${EVON_UUID} " || : && \
    curl -s "https://${ACCOUNT_DOMAIN}/api/bootstrap/linux" -H "Authorization: Token ${EVON_DEPLOY_KEY}" > bootstrap.sh; chmod +x bootstrap.sh && \
    mkdir -p /lib/modules/$(uname -r) && \
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 || : && \
    cmd="./bootstrap.sh --install --no-start ${extra_args}" && \
    echo "Invocation: ${cmd}" && \
    $cmd && \
    echo "Starting OpenVPN..." && \
    cd /etc/openvpn && \
    openvpn evon.conf
