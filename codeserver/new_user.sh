#!/bin/bash -e

clear

set -x

username=$1

password=$2

email=$3

vag cx add-user $username "${password}" $email

vag cx add-user-repo $username git@git.curiosityworks.org/$username/project

vag cx add-user-ide $username vscode

vag cx add-ide-repo $username vscode git@git.curiosityworks.org/$username/project

rm -f ./id_rsa_${username} && ssh-keygen -t rsa -N '' -q -f ./id_rsa_${username}

cat ./id_rsa_${username} | vag cx user-private-key ${username}

cat ./id_rsa_${username}.pub | vag cx user-public-key ${username}

vag cx add-git-user ${username} "${password}" $email

vag cx create-git-user-repo ${username} project

cat ./id_rsa_${username}.pub | vag cx create-git-user-public-key ${username}

rm -f ./id_rsa_${username} ./id_rsa_${username}.pub
