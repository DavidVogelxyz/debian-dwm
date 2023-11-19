#!/bin/sh

################################
# VARIABLES
################################

types=(
"Debian (includes Ubuntu)"
"Arch Linux (includes Artix)"
"NixOS"
"Exit the program"
)

################################
# FUNCTIONS
################################

buildneovim() {
    [ ! -d ~/.local/src/neovim ] \
        && echo "cloning neovim. this may take a moment." \
        && git clone https://github.com/neovim/neovim.git ~/.local/src/neovim > /dev/null 2>&1
    cd ~/.local/src/neovim && git checkout stable > /dev/null 2>&1
    echo "packaging neovim. this may take up to TEN whole moments, depending on your computer's hardware." \
        && make CMAKE_BUILD_TYPE=RelWithDebInfo > /dev/null 2>&1
    echo "updating neovim!" && sudo make install > /dev/null 2>&1
    echo "removing the old neovim." && sudo nala remove neovim -y > /dev/null 2>&1
    echo "For PATH to reset on neovim, close the terminal and open a new shell."
}

buildneovimdependencychecks() {
    if [ $linux = debian ]; then

        pkgs=(
        "cmake"
        "nala"
        "unzip"
        )

        for pkg in "${pkgs[@]}"; do
            [ ! -e /usr/bin/$pkg ] && installcomment && needpkg="yes"
        done

        pkg="gettext" && [ ! -e /usr/lib/x86_64-linux-gnu/$pkg ] && installcomment && needpkg="yes"

        [[ $needpkg = "yes" ]] && exit 1
    fi
}

completiontext() {
    echo "Remember to refresh the shell by closing this terminal session and opening a new one!"
    echo "Also, neovim may throw some error messages when running for the first time. this is normal -- just press enter a bunch and let the plugins install!"
}

conditionalactions() {
    [[ $l33thax = "yes" ]] && echo 'require("lsp-v2")' > ~/.config/nvim/init.lua || rm ~/.config/nvim/after/plugin/lsp.lua

    cp ~/.config/shell/aliasrc-$linux ~/.config/shell/aliasrc && rm ~/.config/shell/aliasrc-*
    [ $linux = debian ] && buildneovim
}

dependencychecks() {
    pkgs=(
    "curl"
    "git"
    )

    for pkg in "${pkgs[@]}"; do
        [ ! -e /usr/bin/$pkg ] && installcomment && needpkg="yes"
    done

    pkg="rg" && [ ! -e /usr/bin/$pkg ] && pkg="ripgrep" && installcomment && needpkg="yes"

    [[ $needpkg = "yes" ]] && exit 1
}

installcomment() {
    echo "'$pkg' is not yet installed on this computer. Please install '$pkg' before proceeding."
}

interactivebit() {
    question1

    question2
}

question1() {
    echo "This is an initialization script for setting up shells on new Linux computers. Please look at the following list and select the best option:"
    PS3="Please choose a number: "

    select type in "${types[@]}"; do
        case $REPLY in
            1) linux=debian; break;;
            2) linux=arch; break;;
            3) linux=nix ; break;;
            4) echo "Exiting now." && exit;;
            *) echo "Unknown response. Try again. $REPLY";;
        esac
    done

    echo "Selected '$type'" && echo

    buildneovimdependencychecks
}

question2() {
    echo "Do you plan to use neovim for coding at any point in the future with this machine?"

    select yn in "obviously!" "neovim?"; do
        case $yn in
            obviously! ) echo "You chose 'yes'."; l33thax="yes"; break;;
            neovim? ) echo "You chose 'no'."; l33thax="no"; break;;
        esac
    done
}

unconditionalactions() {
    [ ! -d ~/.cache/bash ] && mkdir -p ~/.cache/bash
    [ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh

    cd && git init > /dev/null 2>&1
    git remote add dotfiles https://github.com/DavidVogelxyz/dotfiles.git
    git fetch dotfiles > /dev/null 2>&1
    git checkout dotfiles/master -- .
    [ -f ~/.bashrc ] && rm ~/.bashrc ; ln -s .config/bash/.bashrc ~/.bashrc
    [ -f ~/.profile ] && rm ~/.profile ; ln -s .config/shell/profile ~/.profile
    rm -rf .git LICENSE README.md

    git clone https://github.com/DavidVogelxyz/nvim.git ~/.config/nvim
    echo
}

################################
# ACTUAL SCRIPT
################################

dependencychecks

interactivebit

unconditionalactions

conditionalactions

completiontext
