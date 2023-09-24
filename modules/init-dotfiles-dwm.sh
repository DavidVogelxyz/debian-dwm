#!/bin/sh

# Directories
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh
#[ ! -d ~/.local/share ] && mkdir -p ~/.local/share     # already there? believe it should always already be there
#[ ! -d ~/.local/src ] && mkdir -p ~/.local/src         # gets created with `git clone`

# Dotfiles for DWM, etc.
cd && git init > /dev/null 2>&1
git remote add voidrice https://github.com/lukesmithxyz/voidrice.git
git fetch voidrice > /dev/null 2>&1

configs=(
".config/dunst"
".config/fontconfig/fonts.conf"
".config/gtk-2.0"
".config/gtk-3.0"
".config/lf"
".config/mimeapps.list"
".config/mpd"
".config/mpv"
".config/newsboat"
".config/pipewire"
".config/pulse"
".config/shell/bm-dirs"
".config/shell/bm-files"
".config/shell/inputrc"
".config/sxiv"
".config/user-dirs.dirs"
".config/wal"
".config/wget"
".config/x11"
".config/zathura"
".gtkrc-2.0"
".local/"
)

for config in "${configs[@]}"; do
    git checkout voidrice/master -- $config
done

rm -rf .git

files=(
".config/lf/scope-debian"
".config/x11/xprofile"
".local/bin/statusbar/sb-price"
)

for file in "${files[@]}"; do
    curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/master/$file -o ~/$file > /dev/null 2>&1
done
