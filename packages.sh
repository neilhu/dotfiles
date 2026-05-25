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
)

sudo apt install -y "${PACKAGES[@]}"
