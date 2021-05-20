#!/bin/bash -e

set -x

service=lang

version=1.0.0

docker build . -t docker-registry.7onetella.net/7onetella/${service}:"${version}" -f Dockerfile.base

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"
