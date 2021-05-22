#!/bin/bash -e

set -x

repo=languages

version=1.0.1

docker build -t docker-registry.7onetella.net/7onetella/${repo}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${repo}:"${version}"
