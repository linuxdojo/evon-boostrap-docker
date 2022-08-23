# EVON Bootstrap Docker

Use this Docker image to connect a server to your Evon Hub overlay network.

## What is Evon?

Evon (Elastic Virtual Overlay Network) is an OpenVPN-based connectivity system for building an overlay network for disparate servers. The Evon Hub server is distributed as an AWS AMI, reachable at `<account_id>.evon.link`. Connected servers can communicate with each other and are accessible by connected uses, based on policy. Each connected server is reachable via DNS, resolving to private addresses at `<hostname>.<account_id>.evon.link`, using IPv4 routing.

The Evon overlay network allows for frictionless access to managed servers that are otherwise only reachable via bespoke access systems (VPN’s/RDP/Citrix/etc). It also avails unified orchestration, monitoring, centralised logging and other management services of all connected systems via the overlay network, and it provides an AWS bridge for off-cloud systems to utilise AWS resources.

## Usage

To deploy:

```
docker pull linuxdojo/evon-bootstrap:latest
```

Use the below commands to start a bootstrap container and connect to your Evon Hub and overlay network.

Note you must define env vars `ACCOUNT_DOMAIN` and `EVON_DEPLOY_KEY` in the invocation below. For information about these env vars, SSH to your Evon Hub and enter command `evon --help`.

```
docker run -e ACCOUNT_DOMAIN=<YOUR_ACCOUNT_DOMAIN> -e EVON_DEPLOY_KEY=<YOUR_DEPLOY_KEY> --cap-add=net_admin --device=/dev/net/tun --net=host -it linuxdojo/evon-bootstrap
```
