#!/bin/bash -e

clear

# set -x

username=$1

password=$2

email=$3

echo creating user $username 
vag cx add-user $username "${password}" $email

echo
echo creating user repo /$username/project
vag cx add-user-repo $username git@git.curiosityworks.org/$username/project

echo
echo adding user ide vscode
vag cx add-user-ide  $username vscode

echo
echo adding /$username/project to ide instance
vag cx add-ide-repo  $username vscode git@git.curiosityworks.org/$username/project

echo
echo generating private and public key
rm -f ./id_rsa_${username} && ssh-keygen -t rsa -N '' -q -f ./id_rsa_${username}

cat ./id_rsa_${username}     | vag cx user-private-key ${username}

cat ./id_rsa_${username}.pub | vag cx user-public-key ${username}

# --------------------------------------------------------------------------

echo
echo adding user to gitea
vag gitea add-user ${username} "${password}" $email

echo
echo creating repo project in gitea
vag gitea create-user-repo ${username} project

echo
echo adding user\'s public key to gitea
cat ./id_rsa_${username}.pub | vag gitea create-public-key ${username}

echo
echo deleting generated private and public keys
rm -f ./id_rsa_${username} ./id_rsa_${username}.pub
