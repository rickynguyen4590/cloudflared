#!/bin/sh
set -e
exec cloudflared ${CLOUDFLARED_OPTS} "$@"