#!/bin/bash -e

set -x

# ember
sudo sudo npm install -g ember-cli


# github cli gh install
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt-get update
sudo apt-get install gh


# tmux
sudo apt-get install -y tmux
echo -e "\n\nalias s='tmux new -A -s shared'" >> /home/coder/.zshrc

# append install script here dynmically