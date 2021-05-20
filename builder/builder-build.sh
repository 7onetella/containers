#!/bin/bash -e

set -x

cp ~/.ssh/authorized_keys .ssh/

service=builder

group=backend

version=$(vag docker version patch ${service}-${group})

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

vag docker deploy ${service}-${group}:"${version}"
