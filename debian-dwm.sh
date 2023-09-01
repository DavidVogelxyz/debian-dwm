#!/bin/sh

# Package dependency checks
echo "Updating package repositories..."
pkg="nala"
[ -e /usr/bin/$pkg ] && sudo nala update >/dev/null 2>&1 && unset pkg
[[ $pkg = "nala" ]] && sudo apt update >/dev/null 2>&1 && echo "$pkg is not installed. Installing $pkg now..." && sudo apt install $pkg -y >/dev/null 2>&1

pkgs=(
"cmake"
"curl"
"git"
"unzip"
"zsh"
)

for pkg in "${pkgs[@]}"; do
    [ ! -e /usr/bin/$pkg ] && echo "$pkg is not installed on this computer. Installing $pkg now..." && sudo nala install $pkg -y >/dev/null 2>&1
done

pkg="gettext" && [ ! -e /usr/lib/x86_64-linux-gnu/gettext ] && echo "$pkg is not installed on this computer. Installing $pkg now..." && sudo nala install $pkg -y >/dev/null 2>&1
pkg="rg" && [ ! -e /usr/bin/$pkg ] && pkg="ripgrep" && echo "$pkg is not installed on this computer. Installing $pkg now..." && sudo nala install $pkg -y >/dev/null 2>&1

# Installation of modules
mkdir -p modules/completed

modules=(
"init-shell.sh"
"init-p10k.sh"
"init-dotfiles-dwm.sh"
"init-pkgs-dwm.sh"
"init-dwm.sh"
"init-autologin.sh"
"init-nixpkgmgr.sh"
)

for module in "${modules[@]}"; do
    [ -f modules/$module ] && bash modules/$module && mv modules/$module modules/completed
    [ -f modules/$module ] && echo "failed at $module" && gtfo="kthxbye" && break
done

[[ $gtfo = "kthxbye" ]] && exit 1

echo "debian-dwm installation complete!" && echo "Remember to 'bash modules/init-nixpkgs.sh'!"
