#!/bin/sh

# Packages
[ ! -e /usr/bin/curl ] && echo "curl is not installed on this computer. Please install curl before proceeding." && exit 1
[ ! -e /usr/bin/git ] && echo "git is not installed on this computer. Please install git before proceeding." && exit 1
[ ! -e /usr/bin/zsh ] && echo "zsh is not installed on this computer. Please install zsh before proceeding." && exit 1

echo "Elevated privileges are required to properly install the fonts. Please enter your password if asked."

# Directories
[ ! -d /usr/local/share/fonts/m/ ] && sudo mkdir -p /usr/local/share/fonts/m/
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh

# Fonts
[ ! -e /usr/local/share/fonts/m/MesloLGS_NF_Regular.ttf ] && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -o /usr/local/share/fonts/m/MesloLGS_NF_Regular.ttf
[ ! -e /usr/local/share/fonts/m/MesloLGS_NF_Bold.ttf ] && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -o /usr/local/share/fonts/m/MesloLGS_NF_Bold.ttf
[ ! -e /usr/local/share/fonts/m/MesloLGS_NF_Italic.ttf ] && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -o /usr/local/share/fonts/m/MesloLGS_NF_Italic.ttf
[ ! -e /usr/local/share/fonts/m/MesloLGS_NF_Bold_Italic.ttf ] && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -o /usr/local/share/fonts/m/MesloLGS_NF_Bold_Italic.ttf

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/src/powerlevel10k

# Change shell
echo "You will be asked for your password in order to change the default shell to zsh. Please enter your password now."
chsh -s /usr/bin/zsh
