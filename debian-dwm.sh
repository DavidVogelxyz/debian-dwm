#!/bin/sh

# Packages
echo "Updating package repositories..." && sudo apt update >/dev/null 2>&1
[ ! -e /usr/bin/nala ] && echo "nala is not installed. Installing nala..." && sudo apt install nala -y >/dev/null 2>&1
[ ! -e /usr/bin/curl ] && echo "curl is not installed. Installing curl..." && sudo nala install curl -y >/dev/null 2>&1
[ ! -e /usr/bin/git ] && echo "git is not installed. Installing git..." && sudo nala install git -y >/dev/null 2>&1
[ ! -e /usr/bin/zsh ] && echo "zsh is not installed. Installing zsh..." && sudo nala install zsh -y >/dev/null 2>&1

# Installation
[ ! -d modules/already-run ] && mkdir -p modules/already-run
[ ! -f modules/already-run/init-shell.sh ] && ( ( bash modules/init-shell.sh && mv -v modules/init-shell.sh modules/already-run/init-shell.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-p10k.sh ] && ( ( bash modules/init-p10k.sh && mv -v modules/init-p10k.sh modules/already-run/init-p10k.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-dotfiles-dwm.sh ] && ( ( bash modules/init-dotfiles-dwm.sh && mv -v modules/init-dotfiles-dwm.sh modules/already-run/init-dotfiles-dwm.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-pkgs-dwm.sh ] && ( ( bash modules/init-pkgs-dwm.sh && mv -v modules/init-pkgs-dwm.sh modules/already-run/init-pkgs-dwm.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-dwm.sh ] && ( ( bash modules/init-dwm.sh && mv -v modules/init-dwm.sh modules/already-run/init-dwm.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-autologin.sh ] && ( ( bash modules/init-autologin.sh && mv -v modules/init-autologin.sh modules/already-run/init-autologin.sh ) || exit 1 ) || break
[ ! -f modules/already-run/init-nixpkgmgr.sh ] && ( ( bash modules/init-nixpkgmgr.sh && mv -v modules/init-nixpkgmgr.sh modules/already-run/init-nixpkgmgr.sh ) || exit 1 ) || break
# [ ! -f modules/already-run/init-nixpkgs.sh ] && ( ( bash modules/init-nixpkgs.sh && mv -v modules/init-nixpkgs.sh modules/already-run/init-nixpkgs.sh ) || exit 1 ) || break

# cat modules/init-remainder.sh
echo "Remember to 'bash modules/init-nixpkgs.sh'!"
