#!/bin/sh

# Package dependency checks
pkgs=(
"curl"
"git"
"zsh"
)

for pkg in "${pkgs[@]}"; do
    [ ! -e /usr/bin/$pkg ] && echo "$pkg is not installed on this computer. Please install $pkg before proceeding." && needpkg="yes"
done

[[ $needpkg = "yes" ]] && exit 1

# Directories
[ ! -d /usr/local/share/fonts/m/ ] && sudo mkdir -p /usr/local/share/fonts/m/
[ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh

# Install fonts
fonts=(
"MesloLGS_NF_Regular.ttf"
"MesloLGS_NF_Bold.ttf"
"MesloLGS_NF_Italic.ttf"
"MesloLGS_NF_Bold_Italic.ttf"
)

echo "There are $(echo ${#fonts[@]}) fonts to install. It shouldn't take long."
echo "Elevated privileges are required to properly install the fonts. Please enter your password if asked."

for font in "${fonts[@]}"; do
    webfont=$(echo $font | sed 's/_/%20/g')
    [ ! -e /usr/local/share/fonts/m/$font ] && echo "now installing $font ..." && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/$webfont -o /usr/local/share/fonts/m/$font > /dev/null 2>&1
done

# Install 'powerlevel10k'
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/src/powerlevel10k > /dev/null 2>&1

# Change shell
echo "You will be asked for your password in order to change the default shell to zsh. Please enter your password now."
chsh -s /usr/bin/zsh || exit 1
