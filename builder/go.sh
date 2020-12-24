#!/bin/bash

# set -x

SSH_PORT=$(curl -s "http://consul.7onetella.net:8500/v1/health/service/builder-dev-builder-service?dc=dc1" | jq -r ".[0].Service.TaggedAddresses.lan_ipv4.Port")
HOST_IP=$(curl -s "http://consul.7onetella.net:8500/v1/health/service/builder-dev-builder-service?dc=dc1"  | jq -r ".[0].Service.Address")

echo ssh -p ${SSH_PORT} root@${HOST_IP}

# https://docs.w3cub.com/bash/html_node/aliases.html
# Aliases are not expanded when the shell is not interactive, unless the expand_aliases shell option is set using shopt (see The Shopt Builtin).
shopt -s expand_aliases
alias ssh='ssh -o LogLevel=error -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -p ${SSH_PORT} root@${HOST_IP}'

build() {    
  repo=$1
  branch=$2

  CMDS=$(cat << EOF 
# set -x

. ~/.exports

cd /root

if [[ -d "${repo}" ]]; then
    cd ${repo} 
    git reset --hard HEAD
    git clean -df
    git pull origin ${branch}
    ./build.sh
else
    git clone https://github.com/7onetella/${repo}.git
    cd ${repo} 
    ./build.sh
fi

EOF
) 

  ssh -t "${CMDS}"
}

deploy() {    
  repo=$1

  stage=$2

  CMDS=$(cat << EOF 
# set -x

. ~/.exports

cd /root

cd ${repo}

./deploy.sh ${stage}
EOF
) 

  ssh -t "${CMDS}"
}

usage() {
    echo "go.sh <action>"
}

case $1 in
    build)
      shift 1
      build "${1}" "${2}"
      ;;
    deploy)
      shift 1
      deploy "${1}" "${2}"
      ;;
    ssh)
      ssh
      ;;
    *) 
      usage
      ;;
esac
