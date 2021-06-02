#!/bin/bash -e

set -x

languages_version=${1:-1.0.1}

cp ~/.ssh/authorized_keys .ssh/

service=builder

group=backend

version=$(vag docker version patch ${service}-${group})

docker build --build-arg LANGUAGES_VERION=${languages_version} -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:"${version}"
