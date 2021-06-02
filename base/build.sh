#!/bin/bash -e

set -x

repo=base

version=${1:-1.0.0}

docker build -t docker-registry.7onetella.net/7onetella/${repo}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${repo}:"${version}"
