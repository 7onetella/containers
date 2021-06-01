#!/bin/bash -e

# set -x

username=$1

password=$2

email=$3

echo -e "adding user                : $username"
vag cx add-user $username "${password}" $email

echo -e "adding user_repo           : /$username/project"
vag cx add-user-repo $username ssh://gitea@git-ssh.curiosityworks.org:2222/${username}/project.git                               

echo -e "adding user_ide            : vscode"
vag cx add-user-ide  $username vscode

echo -e "adding ide_repo            : /$username/project"
vag cx add-ide-repo  $username vscode ssh://gitea@git-ssh.curiosityworks.org:2222/${username}/project.git

rm -f ./id_rsa_${username} && ssh-keygen -t rsa -N '' -q -f ./id_rsa_${username}

echo -e "adding private_key         :"
cat ./id_rsa_${username}     | vag cx user-private-key ${username}

echo -e "adding public_key          :"
cat ./id_rsa_${username}.pub | vag cx user-public-key ${username}

# --------------------------------------------------------------------------

echo
echo adding user to gitea
vag gitea add-user ${username} "${password}" $email

echo adding repo to gitea
vag gitea create-user-repo ${username} project

echo adding user\'s public key to gitea
cat ./id_rsa_${username}.pub | vag gitea create-public-key ${username}

rm -f ./id_rsa_${username} ./id_rsa_${username}.pub

./build.sh ${username}