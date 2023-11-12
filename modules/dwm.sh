#!/bin/sh

################################
# VARIABLES
################################

repos=(
"dmenu"
"dwm"
"dwmblocks"
"st"
)

################################
# FUNCTIONS
################################

compiledwm() {
    for repo in "${repos[@]}"; do
        git clone https://github.com/DavidVogelxyz/$repo ~/.local/src/$repo > /dev/null 2>&1
        [ -d ~/.local/src/$repo ] && cd ~/.local/src/$repo && sudo make install > /dev/null 2>&1
    done
}

wallpaper() {
    [ ! -e ~/.local/share/Emerald-wallpaper_1920x1080.png ] && cp Emerald-wallpaper_1920x1080.png ~/.local/share
    [ -e ~/.local/share/bg ] && rm ~/.local/share/bg
    ln -s ~/.local/share/Emerald-wallpaper_1920x1080.png ~/.local/share/bg
}

################################
# ACTUAL SCRIPT
################################

wallpaper

compiledwm
