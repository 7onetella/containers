#!/bin/bash -e

set -x

userid=$1    

password=$2

email={$3}

service=vscode-${userid}

group=public

cp ~/.ssh/id_rsa .ssh

version=$(vag docker version patch ${service}-${group})

cat config.yml.tpl | sed 's/__secret__/'"${password}"'/g' > config.yml

cat .gitconfig.tpl | sed 's/__name__/'"${userid}"'/g' | sed 's/__email__/'"${email}"'/g' > .gitconfig

cat vscode.app.tpl | sed 's/__userid__/'"${userid}"'/g' > vscode-${userid}-public.app

docker build -t docker-registry.7onetella.net/7onetella/${service}:"${version}" .

docker push docker-registry.7onetella.net/7onetella/${service}:"${version}"

nomad job stop -purge ${service} || true

vag docker deploy docker-registry.7onetella.net/7onetella/${service}-${group}:"${version}"

rm config.yml

rm vscode-${userid}-public.app