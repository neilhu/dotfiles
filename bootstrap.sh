#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

RSYNC_EXCLUDES=(
	--exclude ".git/"
	--exclude ".claude/"
	--exclude "init/"
	--exclude ".DS_Store"
	--exclude "bootstrap.sh"
	--exclude "brew.sh"
	--exclude "README.md"
	--exclude "LICENSE-MIT.txt"
)

function doBackup() {
	local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
	local backed_up=0

	while IFS= read -r f; do
		if [ -e "$HOME/$f" ] && [ ! -d "$HOME/$f" ]; then
			mkdir -p "$backup_dir/$(dirname "$f")"
			cp -a "$HOME/$f" "$backup_dir/$f"
			backed_up=$((backed_up + 1))
		fi
	done < <(rsync "${RSYNC_EXCLUDES[@]}" -avn --no-perms --itemize-changes . ~ \
		| awk '/^>f/ { print $2 }')

	if [ "$backed_up" -gt 0 ]; then
		echo "Backed up $backed_up file(s) to $backup_dir";
	else
		echo "No existing files to back up.";
	fi;
}

function doIt() {
	doBackup;
	rsync "${RSYNC_EXCLUDES[@]}" -avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt doBackup RSYNC_EXCLUDES;
