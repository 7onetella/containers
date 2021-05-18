#!/bin/bash -e

set -x

cp ~/.ssh/authorized_keys .ssh/

version=${1}

docker build . -t docker-registry.7onetella.net/7onetella/nginx:"${version}" -f Dockerfile

docker push docker-registry.7onetella.net/7onetella/nginx:"${version}"

vag docker deploy nginx-dev:"${version}"