#!/usr/bin/env bash

set -e

# TODO: following stuff is all linux, need to figure out mac
case "$(uname -s)" in

	Darwin)
		echo 'todo: mac os x setup, install homebrew etc'
		;;

	Linux)
		if ! command -v stow &> /dev/null; then
			sudo apt-get update -qq && sudo apt-get install -y -qq stow
		fi
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
	if test -f "$original_path" && ! test -L "$original_path"; then
		new_destination="$HOME/$file.orig"
		echo "moving existing $original_path to $new_destination"
		mv "$original_path" "$new_destination"
	fi
done

# directories that other tools create before we get to stow them
dirs_to_backup=(".codex")
for dir in ${dirs_to_backup[@]}; do
	original_path="$HOME/$dir"
	if test -d "$original_path" && ! test -L "$original_path"; then
		new_destination="$HOME/$dir.bak"
		rm -rf "$new_destination"
		echo "moving existing $original_path to $new_destination"
		mv "$original_path" "$new_destination"
	fi
done


# --adopt moves conflicting target files into the repo, creating symlinks.
# Then restore the repo's committed versions, which flow through the symlinks
# — making the dotfiles repo the source of truth.
stow --adopt . -t $HOME -v 2
if [ -d .jj ]; then
	jj restore
else
	git checkout .
fi
