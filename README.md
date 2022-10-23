# EVON Bootstrap Docker

Use this Docker image to connect a server to your Evon Hub overlay network.

## What is Evon?

Evon (Elastic Virtual Overlay Network) is an OpenVPN-based connectivity system for building an overlay network for remote servers. The Evon Hub server is distributed in AWS Marketplace. Once deployed, it is reachable at `<your-biz>.evon.link`. Connected servers can communicate with each other and are accessible by connected uses, based on policy. Each connected server is reachable via DNS, resolving to private addresses at `<hostname>.<your-biz>.evon.link`, using IPv4 routing.

The Evon overlay network allows for frictionless, centralised access to managed servers that are otherwise only reachable via bespoke access systems (VPN’s/RDP/Citrix/etc). It also avails unified orchestration, monitoring, centralised logging and other management services of all connected systems via the overlay network, and it provides an AWS bridge for off-cloud systems to utilise AWS resources.

## Usage

To deploy:

```
docker pull linuxdojo/evon-bootstrap:latest
```

Use the below commands to start a bootstrap container and connect to your Evon Hub and overlay network.

Note you must define env vars `ACCOUNT_DOMAIN` and `EVON_DEPLOY_KEY` in the invocation below, where:

* `ACCOUNT_DOMAIN` is the FQDN used to reach your Evon Hub, eg `mybiz.evon.link`
* `EVON_DEPLOY_KEY` is the API key for the `deployer` user, or any superuser.

You may also provide an optional env var named `EVON_HOSTNAME` which will cause this system to be registered as `<EVON_HOSTNAME>.mybiz.evon.link`. If omitted, HOSTNAME will become the output of the `uname -n` command inside the Docker container.

```
docker run -e ACCOUNT_DOMAIN=<your_account_domain> -e EVON_DEPLOY_KEY=<your_deploy_key> -e EVON_HOSTNAME=<your_server_hostname> --cap-add=net_admin --device=/dev/net/tun --net=host -it linuxdojo/evon-bootstrap
```
