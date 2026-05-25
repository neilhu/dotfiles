#!/usr/bin/env bash

# Install apt packages required by these dotfiles.
# Run once on a fresh machine after bootstrap.sh.

sudo apt update

PACKAGES=(
	# Shell utilities
	bash-completion
	fzf

	# Clipboard (xclip for X11; wl-clipboard for Wayland)
	xclip
	wl-clipboard

	# For `o` / xdg-open
	xdg-utils

	# For `digga` and the public `ip` alias
	dnsutils

	# For `tre`
	tree

	# For `gz`
	bc

	# For `targz`
	pigz

	# For `mergepdf`
	ghostscript

	# For `getcertnames` / `dataurl`
	openssl

	# HTTP verb aliases (GET, POST, etc.)
	libwww-perl

	# tmux
	tmux

	# vim
	vim

	# direnv: per-project environment variables
	direnv
)

sudo apt install -y "${PACKAGES[@]}"

# Optional modern CLI replacements (faster/nicer than grep/cat/find)
OPTIONAL=(
	ripgrep   # rg: faster grep
	bat       # bat: cat with syntax highlighting
	fd-find   # fd: simpler, faster find
)

echo ""
echo "Install optional modern CLI tools? (y/n)"
read -r -n 1 REPLY
echo ""
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
	sudo apt install -y "${OPTIONAL[@]}"
	# fd-find installs as fdfind; symlink to fd
	if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
		ln -s "$(command -v fdfind)" ~/.local/bin/fd
	fi
fi
