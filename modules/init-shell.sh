#!/bin/sh

# Package dependency checks
pkgs=(
"curl"
"git"
)

for pkg in "${pkgs[@]}"; do
    [ ! -e /usr/bin/$pkg ] && echo "$pkg is not installed on this computer. Please install $pkg before proceeding." && needpkg="yes"
done

pkg="rg" && [ ! -e /usr/bin/$pkg ] && pkg="ripgrep" && echo "$pkg is not installed on this computer. Please install $pkg before proceeding." && needpkg="yes"

[[ $needpkg = "yes" ]] && exit 1

# Interactive bit
types=(
"Debian (includes Ubuntu)"
"Arch Linux (includes Artix)"
"NixOS"
"Exit the program"
)

echo "This is an initialization script for setting up shells on new Linux computers. Please look at the following list and select the best option:"
PS3="Please choose a number: "

select type in "${types[@]}"; do
    case $REPLY in
        1) linux=deb; break;;
        2) linux=arch; break;;
        3) linux=nix ; break;;
        4) echo "Exiting now." && exit;;
        *) echo "Unknown response. Try again. $REPLY";;
    esac
done

echo "Selected '$type'" && echo

# Check Debian for neovim build dependencies
if [ $linux = deb ]; then

    pkgs=(
    "cmake"
    "nala"
    "unzip"
)

    for pkg in "${pkgs[@]}"; do
        [ ! -e /usr/bin/$pkg ] && echo "$pkg is not installed on this computer. Please install $pkg before proceeding." && needpkg="yes"
    done

    [ ! -e /usr/lib/x86_64-linux-gnu/gettext ] && echo "gettext is not installed on this computer. Please install gettext before proceeding." && needpkg="yes"

    [[ $needpkg = "yes" ]] && exit 1
fi

echo "Do you plan to use neovim for coding at any point in the future with this machine?"

select yn in "obviously!" "neovim?"; do
	case $yn in
		obviously! ) echo "You chose 'yes'."; l33thax="yes"; break;;
		neovim? ) echo "You chose 'no'."; l33thax="no"; break;;
	esac
done

# Add directories
[ ! -d ~/.cache/bash ] && mkdir -p ~/.cache/bash
[ ! -d ~/.cache/shell ] && mkdir -p ~/.cache/shell
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh

# Unconditional actions
cd && git init > /dev/null 2>&1
git remote add dotfiles https://github.com/DavidVogelxyz/dotfiles.git
git fetch dotfiles > /dev/null 2>&1
git checkout dotfiles/master -- .
[ -f ~/.bashrc ] && rm ~/.bashrc ; ln -s .config/bash/.bashrc ~/.bashrc
[ -f ~/.profile ] && rm ~/.profile ; ln -s .config/shell/profile ~/.profile
sudo rm -r .git > /dev/null 2>&1
rm LICENSE && rm README.md
echo

# Conditional actions
[[ $l33thax = "yes" ]] && echo 'require("lsp-v2")' > ~/.config/nvim/init.lua || rm ~/.config/nvim/after/plugin/lsp.lua

[ $linux = arch ] && mv ~/.config/shell/aliasrc-arch ~/.config/shell/aliasrc
[ $linux = nix ] && mv ~/.config/shell/aliasrc-nix ~/.config/shell/aliasrc
if [ $linux = deb ]; then
    mv ~/.config/shell/aliasrc-debian ~/.config/shell/aliasrc
    # update neovim
    [ ! -d ~/.local/src/neovim ] && echo "cloning neovim. this may take a moment." && git clone https://github.com/neovim/neovim.git ~/.local/src/neovim > /dev/null 2>&1
    cd ~/.local/src/neovim && git checkout tags/stable > /dev/null 2>&1
    echo "packaging neovim. this may take up to TEN whole moments." && make CMAKE_BUILD_TYPE=RelWithDebInfo > /dev/null 2>&1
    echo "updating neovim!" && sudo make install > /dev/null 2>&1
    echo "removing the old neovim." && sudo nala remove neovim -y > /dev/null 2>&1
    echo "For PATH to reset on neovim, close the terminal and open a new shell."
fi

rm ~/.config/shell/aliasrc-*

echo "Remember to refresh the shell with '$ source ~/.bashrc'!"
echo "Also, neovim may throw some error messages on first run. that is normal -- just press enter a bunch and let the plugins install!"
