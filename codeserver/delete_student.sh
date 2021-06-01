#!/bin/bash -e

# set -x

username=$1

echo --------------------------------------------
echo deleting from gitea    
vag gitea delete-user-repo ${username} project --debug
vag gitea delete-user ${username}

echo 
echo --------------------------------------------
echo deleting from database 
vag cx delete-user ${username}

echo --------------------------------------------
echo deleting from nomad    
nomad job stop -purge vscode-${username}