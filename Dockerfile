FROM alpine:3.16.2

RUN apk add bash curl grep openssl openvpn cpio uuidgen openrc jq
WORKDIR /root
CMD [ -z $EVON_DEPLOY_KEY ] && echo "ERROR: You must define environment variable EVON_DEPLOY_KEY to start this container." && exit 1 || \
    [ -z $ACCOUNT_DOMAIN ] && echo "ERROR: You must define environment variable ACCOUNT_DOMAIN to start this container." && exit 1 || \
    curl -s "https://${ACCOUNT_DOMAIN}/api/bootstrap/download" -H "Authorization: Token ${EVON_DEPLOY_KEY}" > bootstrap.sh; chmod +x bootstrap.sh && \
    mkdir -p /lib/modules/$(uname -r) && \
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 || : && \
    ./bootstrap.sh --install --no-start --hostname "${EVON_HOSTNAME}" && \
    cd /etc/openvpn && \
    openvpn evon.conf
