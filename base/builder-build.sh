#!/bin/bash -e

set -x

cp ~/.ssh/authorized_keys builder/.ssh/

version=${1}

docker build . -t docker-registry.7onetella.net/7onetella/builder:"${version}" -f Dockerfile.builder

docker push docker-registry.7onetella.net/7onetella/builder:"${version}"

vag docker deploy builder-dev:"${version}"
