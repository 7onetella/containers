#!/bin/bash -e

set -x

repo=languages

base_version=${1:-1.0.0}

version=${2:-1.0.1}

docker build --build-arg BASE_VERION=${base_version} -t docker-registry.7onetella.net/7onetella/${repo}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${repo}:"${version}"
