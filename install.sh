if test -f ~/.gitconfig; then
	echo "moving existing gitconfig to ~/.gitconfig.orig"
	mv ~/.gitconfig ~/.gitconfig.orig
fi

cp .gitconfig ~/.gitconfig
