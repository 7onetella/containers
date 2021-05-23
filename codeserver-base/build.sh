#!/bin/bash -e

set -x

service=codeserver-base

version=1.0.1

docker build --no-cache -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"


# chnagelog
# 1.0.1 - reverting code server back to 3.10.0 to fix python plugin click through issue