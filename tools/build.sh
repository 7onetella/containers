#!/bin/bash -e

set -x

languages_version=${1:-1.0.1}

version=${2:-1.0.1}

cp ~/.ssh/authorized_keys .ssh/

service=tools

docker build --build-arg LANGUAGES_VERSION=${languages_version} -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"
