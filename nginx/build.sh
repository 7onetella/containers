#!/bin/bash -e

set -x

service=nginx

group=public

cp ~/.ssh/authorized_keys .ssh/

version=$(vag docker version patch ${service}-${group})

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

nomad job stop -purge ${service}

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:"${version}"