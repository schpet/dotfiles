#!/usr/bin/env bash

set -e

# TODO: following stuff is all linux, need to figure out mac
case "$(uname -s)" in

	Darwin)
		echo 'todo: mac os x setup, install homebrew etc'
		;;

	Linux)
		echo 'todo: linux setup'
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
