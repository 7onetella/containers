#!/bin/bash -e

set -x

service=base

version=1.0.0

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"
