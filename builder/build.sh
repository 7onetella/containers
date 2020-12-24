#!/bin/bash

set -x

version=${1}

cp ~/id_rsa.pub .ssh/authorized_keys

image=docker-registry.7onetella.net:5000/7onetella/builder:"${version}"

docker build -t "${image}" .

docker push "${image}"

cat builder.nomad.tpl | sed 's/__tag__/'"${version}"'/g' > builder.nomad

nomad job run ./builder.nomad