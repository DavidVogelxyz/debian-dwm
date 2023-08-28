#!/bin/sh

PS3="Configure for which operating system? "
items=("Debian (includes Ubuntu)" "Arch Linux (includes Artix)" "NixOS")

select item in "${items[@]}" Quit
do
    case $REPLY in
        1) echo "Selected '$item'"; installOS=deb; break;;
        2) echo "Selected '$item'"; installOS=arch; break;;
        3) echo "Selected '$item'"; installOS=nix ; break;;
        $((${#items[@]}+1))) echo "Exiting now."; exit;;
        *) echo "Unknown response. Try again. $REPLY";;
    esac
done

# Package dependency checks
[ ! -e /usr/bin/curl ] && echo "curl is not installed on this computer. Please install curl before proceeding." && exit 1
[ ! -e /usr/bin/git ] && echo "git is not installed on this computer. Please install git before proceeding." && exit 1

# Directories
[ ! -d ~/.cache/bash ] && mkdir -p ~/.cache/bash
[ ! -d ~/.cache/shell ] && mkdir -p ~/.cache/shell
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh
[ ! -d ~/.config/bash ] && mkdir -p ~/.config/bash
[ ! -d ~/.config/nvim ] && mkdir -p ~/.config/nvim
[ ! -d ~/.config/shell ] && mkdir -p ~/.config/shell
[ ! -d ~/.config/zsh ] && mkdir -p ~/.config/zsh

# Conditional
if [ $installOS = deb ] ; then
	curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/shell/aliasrc-debian -o ~/.config/shell/aliasrc
elif [ $installOS = arch ] ; then
	curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/shell/aliasrc-arch -o ~/.config/shell/aliasrc
elif [ $installOS = nix ] ; then
	curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/shell/aliasrc-nix -o ~/.config/shell/aliasrc
elif [ $installOS = * ] ; then
	echo "No alias file found for that OS!"
fi

# Unconditional
curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/nvim/init.vim -o ~/.config/nvim/init.vim

curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/bash/.bashrc -o ~/.config/bash/.bashrc
[ -f ~/.bashrc ] && rm ~/.bashrc ; ln -s .config/bash/.bashrc ~/.bashrc
curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/shell/profile -o ~/.config/shell/profile
[ -f ~/.profile ] && rm ~/.profile ; ln -s .config/shell/profile ~/.profile
[ -f ~/.zprofile ] && rm ~/.zprofile ; ln -s .config/shell/profile ~/.zprofile
curl -L https://raw.githubusercontent.com/DavidVogelxyz/dotfiles/main/.config/zsh/.zshrc -o ~/.config/zsh/.zshrc

echo "Remember to refresh the shell with '$ source ~/.bashrc'!"
