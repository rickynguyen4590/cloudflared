ARG GOLANG_VERSION=1.16.4
ARG ALPINE_VERSION=3.13
ARG UPSTREAM_RELEASE_TAG=2021.5.10

FROM golang:${GOLANG_VERSION}-alpine${ALPINE_VERSION} as gobuild
ARG GOLANG_VERSION
ARG ALPINE_VERSION
ARG UPSTREAM_RELEASE_TAG

WORKDIR /tmp

RUN apk add --no-cache git gcc build-base curl tar && \
    mkdir release && \
    curl -L "https://github.com/cloudflare/cloudflared/archive/refs/tags/${UPSTREAM_RELEASE_TAG}.tar.gz" | tar xvz --strip 1 -C ./release

WORKDIR /tmp/release/cmd/cloudflared

RUN go build ./

FROM alpine:${ALPINE_VERSION}

ARG GOLANG_VERSION
ARG ALPINE_VERSION

LABEL maintainer="Ricky"


RUN adduser -S cloudflared; \
    apk add --no-cache ca-certificates bind-tools libcap; \
    rm -rf /var/cache/apk/*;

COPY --from=gobuild /tmp/release/cmd/cloudflared/cloudflared /usr/local/bin/cloudflared
COPY ./entrypoint.sh /entrypoint.sh

USER cloudflared

ENTRYPOINT ["/entrypoint.sh"]
