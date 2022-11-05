# EVON Bootstrap Docker

Use this Docker image to connect a server to your Evon virtual overlay network.

## What is Evon?

Evon (Elastic Virtual Overlay Network) is an OpenVPN-based connectivity system for building a virtual overlay network for remote servers. The Evon Hub server is distributed as an AWS AMI. Once deployed, it is reachable at `<your-biz>.evon.link`. Connected servers and users can communicate with each other based on policy. Each connected server is reachable via DNS, resolving to private addresses at `<hostname>.<your-biz>.evon.link`, using IPv4 routing. Evon Hub provides a Web UI, REST API, DevOps friendly CLI tools for automated deployment and provisioning, HTTP proxy support. Visit https://linuxdojo.com/evon for more info.

## Usage

To deploy:

```
docker pull linuxdojo/evon-bootstrap:latest
```

Use the below commands to start a bootstrap container and connect your server to your Evon Hub overlay network.

### Mandatory Environment Variables

You must define env vars `ACCOUNT_DOMAIN` and `EVON_DEPLOY_KEY` in the invocation below, where:

* `ACCOUNT_DOMAIN` is the FQDN used to reach your Evon Hub, eg `mybiz.evon.link`
* `EVON_DEPLOY_KEY` is the API key for the `deployer` user, or any superuser.

### Optional Environment Variables

You may also provide the following optional env vars:

* `EVON_HOSTNAME` - will cause this system to be registered as `<EVON_HOSTNAME>.mybiz.evon.link`. If omitted, HOSTNAME will become the output of the `uname -n` command inside the Docker container.
* `EVON_UUID` - a UUID version 4 string (as outputted by the `uuidgen` command on Linux), and maps to a static IPv4 address on the overlay network. For never seen before UUID's, a new IPv4 address will be permanently assigned to the new UUID. If this env var is omitted, a new UUID will be auto-generated each time the Docker container is run.
* `EXTRA_ARGS` - any extra arguments you may wish to provide to the `boostrap.sh` installer that is executed inside the container, eg `--extra-config <FILE>`. Note that `<FILE>` in this example must be local within the container, therefore either the `--volume` or `--mount` Docker run options should be used to inject `<FILE>` into the container at runtime. Refer to the [Docker docs](https://docs.docker.com/engine/reference/commandline/run/#add-bind-mounts-or-volumes-using-the---mount-flag) for more info. Download and run `bootstrap.sh` from your Evon Hub with the `--help` option for info about the `--extra-config` and other options available.

```
docker run \
  -it \
  -d \
  --restart unless-stopped \
  -e ACCOUNT_DOMAIN=<your_account_domain> \
  -e EVON_DEPLOY_KEY=<your_deploy_key> \
  -e EVON_HOSTNAME=<your_server_hostname> \
  -e EVON_UUID=<uuid_value> \
  --cap-add=net_admin \
  --device=/dev/net/tun \
  --net=host \
  linuxdojo/evon-bootstrap
```

### Running in the Foreground

Remove the `-d` option from the `docker run` command to run the container in the foreground. For more info, see https://docs.docker.com/engine/reference/run/#detached--d

### Restarting Automatically

The `--restart unless-stopped` option to the `docker run` command will restart the container automatically when it exits, or when Docker restarts. Remove this option to suppress automatic restart. For more info, see https://docs.docker.com/config/containers/start-containers-automatically/

## Source

https://github.com/linuxdojo/evon-boostrap-docker
