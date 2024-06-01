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
    sudo apt update >/dev/null 2>&1

    [ ! -e /usr/bin/nala ] && pkg="nala" \
        && installcomment && installpkg
}

installcomment() {
    echo "Installing '$pkg' now..."
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
    [ ! -e /usr/lib/x86_64-linux-gnu/gettext ] && pkg="gettext" \
        && installcomment && installpkg

    [ ! -e /usr/bin/rg ] && pkg="ripgrep" \
        && installcomment && installpkg
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
