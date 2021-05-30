#!/bin/bash -e

# set -x

username=$1

echo 
echo deleting user ${username} from user database
vag cx delete-user ${username}

echo
echo deleting user repo /${username}/project from gitea
vag gitea delete-user-repo ${username} project

echo
echo deleting gitea user account for ${username}
vag gitea delete-user ${username}

nomad job stop -purge vscode-${username}