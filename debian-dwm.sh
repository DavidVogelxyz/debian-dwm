#!/bin/sh

################################
# VARIABLES
################################

modules=(
"shell.sh"
"p10k.sh"
"dotfiles-dwm.sh"
"pkgs-dwm.sh"
"dwm.sh"
"autologin.sh"
"nixpkgmgr.sh"
)

################################
# FUNCTIONS
################################

nalacheck() {
    echo "Updating package repositories..."
    [ -e /usr/bin/nala ] && sudo nala update >/dev/null 2>&1
    [ ! -e /usr/bin/nala ] && sudo apt update >/dev/null 2>&1 \
        && pkg="nala" && installcomment && sudo apt install $pkg -y >/dev/null 2>&1
}

installcomment() {
    echo "'$pkg' is not yet installed on this computer. Installing '$pkg' now..."
}

installloop() {
    pkgs=(
    "cmake"
    "curl"
    "git"
    "stow"
    "unzip"
    "zsh"
    )

    for pkg in "${pkgs[@]}"; do
        [ ! -e /usr/bin/$pkg ] && installcomment && installpkg
    done

    installspecial
}

installpkg() {
    sudo apt install $pkg -y >/dev/null 2>&1
}

installspecial() {
    pkg="gettext" && [ ! -e /usr/lib/x86_64-linux-gnu/gettext ] \
        && installcomment && installpkg

    pkg="rg" && [ ! -e /usr/bin/$pkg ] \
        && pkg="ripgrep" && installcomment && installpkg
}

moduleloop() {
    mkdir -p modules/completed

    for module in "${modules[@]}"; do
        [ -f modules/$module ] \
            && bash modules/$module && mv modules/$module modules/completed
        [ -f modules/$module ] \
            && echo "failed at $module!" && exit 1
    done
}

completiontext() {
    echo "debian-dwm installation complete!" && echo "Remember to 'bash modules/nixpkgs.sh'!"
}

################################
# ACTUAL SCRIPT
################################

nalacheck

installloop

moduleloop

completiontext
