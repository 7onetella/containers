#!/bin/bash

set -xe

version=${1}

image=docker-registry.7onetella.net/7onetella/builder:"${version}"

docker push "${image}"

cat builder.nomad.tpl | sed 's/__tag__/'"${version}"'/g' > builder.nomad

nomad job run ./builder.nomad