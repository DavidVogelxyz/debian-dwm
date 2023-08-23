#!/bin/sh

# Preparations
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh
# [ ! -d ~/.local/share ] && mkdir -p ~/.local/share	# already there? not sure why commented out but seems to be okay
# [ ! -d ~/.local/src ] && mkdir -p ~/.local/src	# gets created with `git clone`

# Dotfiles for DWM, etc.
cd ~
git init
git remote add voidrice https://github.com/lukesmithxyz/voidrice.git
git fetch voidrice
git checkout voidrice/master -- .config/dunst
git checkout voidrice/master -- .config/fontconfig/fonts.conf
git checkout voidrice/master -- .config/gtk-2.0
git checkout voidrice/master -- .config/gtk-3.0
git checkout voidrice/master -- .config/lf
git checkout voidrice/master -- .config/mimeapps.list
git checkout voidrice/master -- .config/mpd
git checkout voidrice/master -- .config/mpv
git checkout voidrice/master -- .config/newsboat
git checkout voidrice/master -- .config/pipewire
git checkout voidrice/master -- .config/pulse
git checkout voidrice/master -- .config/shell/bm-dirs
git checkout voidrice/master -- .config/shell/bm-files
git checkout voidrice/master -- .config/shell/inputrc
# git checkout voidrice/master -- .config/shell/profile		# loading profile file earlier; also loading my own custom file
git checkout voidrice/master -- .config/sxiv
git checkout voidrice/master -- .config/user-dirs.dirs
git checkout voidrice/master -- .config/wal
git checkout voidrice/master -- .config/wget
git checkout voidrice/master -- .config/x11
git checkout voidrice/master -- .config/zathura
# git checkout voidrice/master -- .config/zsh			# loading zsh file earlier; also loading my own custom file
git checkout voidrice/master -- .gtkrc-2.0
git checkout voidrice/master -- .local/
git checkout voidrice/master -- .xprofile
# git checkout voidrice/master -- .zprofile			# loading profile file earlier; also loading my own custom file

curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/lf/scope-debian -o ~/.config/lf/scope
curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.local/bin/statusbar/sb-price -o ~/.local/bin/statusbar/sb-price

sudo rm -rv ~/.git
