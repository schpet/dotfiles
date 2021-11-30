#!/usr/bin/env bash

set -e

# later: use stow, figure out how to deal with conflicts
if test -f ~/.gitconfig; then
	echo "moving existing gitconfig to ~/.gitconfig.orig"
	mv ~/.gitconfig ~/.gitconfig.orig
fi

cp .gitconfig ~/.gitconfig

# TODO: following stuff is all linux, need to figure out mac

sudo apt-get update
sudo export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install --no-install-recommends bat ripgrep vim stow

# gh cli
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh


