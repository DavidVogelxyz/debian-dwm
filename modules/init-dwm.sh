#!/bin/sh

# Source code for DWM, etc.
git clone https://github.com/davidvogelxyz/dmenu ~/.local/src/dmenu
git clone https://github.com/davidvogelxyz/dwm-debian ~/.local/src/dwm-debian
git clone https://github.com/davidvogelxyz/dwmblocks ~/.local/src/dwmblocks
git clone https://github.com/davidvogelxyz/st ~/.local/src/st

# Compile DWM
[ -d ~/.local/src/dmenu ] && cd ~/.local/src/dmenu && sudo make install
[ -d ~/.local/src/dwm-debian ] && cd ~/.local/src/dwm-debian && sudo make install
[ -d ~/.local/src/dwmblocks ] && cd ~/.local/src/dwmblocks && sudo make install
[ -d ~/.local/src/st ] && cd ~/.local/src/st && sudo make install

[ ! -e ~/.local/share/Emerald-wallpaper_1920x1080.png ] && cp ~/.local/src/debian-dwm/Emerald-wallpaper_1920x1080.png ~/.local/share
rm ~/.local/share/bg ; ln -s Emerald-wallpaper_1920x1080.png ~/.local/share/bg
