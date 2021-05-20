#!/bin/bash -e

set -x

cp ~/.ssh/authorized_keys builder/.ssh/

service=builder

group=backend

version=$(vag docker version patch ${service}-${group})

docker build . -t docker-registry.7onetella.net/7onetella/${service}:"${version}" -f Dockerfile.builder

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

vag docker deploy ${service}-${group}:"${version}"
