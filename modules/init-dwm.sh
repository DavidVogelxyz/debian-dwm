#!/bin/sh

# While working directory is still the 'debian-dwm' repo
[ ! -e ~/.local/share/Emerald-wallpaper_1920x1080.png ] && cp Emerald-wallpaper_1920x1080.png ~/.local/share
[ -e ~/.local/share/bg ] && rm ~/.local/share/bg
ln -s ~/.local/share/Emerald-wallpaper_1920x1080.png ~/.local/share/bg

# Compile dwm and other suckless tools from source code
repos=(
"dmenu"
"dwm"
"dwmblocks"
"st"
)

for repo in "${repos[@]}"; do
    git clone https://github.com/DavidVogelxyz/$repo ~/.local/src/$repo > /dev/null 2>&1
    [ -d ~/.local/src/$repo ] && cd ~/.local/src/$repo && sudo make install > /dev/null 2>&1
done
