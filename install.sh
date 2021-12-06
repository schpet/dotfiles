#!/usr/bin/env bash

set -e

# TODO: following stuff is all linux, need to figure out mac
case "$(uname -s)" in

	Darwin)
		echo 'todo: mac os x setup, install homebrew etc'
		;;

	Linux)
		echo "installing linux deps!"

		sudo apt-get update
		export DEBIAN_FRONTEND=noninteractive
		sudo apt-get -y install --no-install-recommends bat stow

		# gh cli
		curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
		echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
		sudo apt update
		sudo apt install gh

		# ripgrep
		curl -sLO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
		sudo dpkg -i ripgrep_13.0.0_amd64.deb
		rm ripgrep_13.0.0_amd64.deb

		# heroku cli
		curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

		# starship
		curl -fsSL https://starship.rs/install.sh > starship.sh
		sh starship.sh -f
		rm starship.sh
     ;;

   CYGWIN*|MINGW32*|MSYS*|MINGW*)
     echo 'todo: windows'
     ;;

   *)
     echo "Unknown os: $(uname -s)"
     ;;
esac


# codespaces comes with a few defaults that i don't want to clobber blindly
files_to_backup=(".gitconfig" ".zshrc")
for file in ${files_to_backup[@]}; do
	original_path="$HOME/$file"
	if test -f $original_path; then
		new_destination="$HOME/$file.orig"
		echo "moving existing $original_path to $new_destination"
		mv "$original_path" "$new_destination"
	fi
done


stow . -t $HOME -v 2