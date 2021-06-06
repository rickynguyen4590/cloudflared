# 
[![build status](https://github.com/rickynguyen4590/cloudflared/actions/workflows/main.yaml/badge.svg)](https://github.com/rickynguyen4590/cloudflared/actions/workflows/main.yaml)

[![docker image size](https://img.shields.io/docker/image-size/rickynguyen4/cloudflared/latest)](https://hub.docker.com/r/rickynguyen4590/cloudflared)
[![docker pulls](https://img.shields.io/docker/pulls/rickynguyen4590/cloudflared.svg)](https://hub.docker.com/r/rickynguyen4590/cloudflared/)
[![license](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

# Argo Tunnel client

Contains the command-line client for Argo Tunnel, a tunneling daemon that proxies any local webserver through the Cloudflare network. Extensive documentation can be found in the [Argo Tunnel section](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps) of the Cloudflare Docs.

## Using with Github action service
Support to access TCP tunnel created by cloudflare such as access private minikube.
```yml:
services:
    cloudflared:
    image: rickynguyen/cloudflared
    env:
        CLOUDFLARED_OPTS: access tcp --hostname ${{ secrets.CLOUDFLARE_K8S_HOSTNAME }} --listener 0.0.0.0:16443
    ports:
        - 16443:16443
steps:
    - uses: actions-hub/kubectl@master
      env:
        KUBE_CONFIG: ${{ secrets.KUBE_CONFIG }}
      with:
        args: get pods

```
## License

Distributed under the MIT license
