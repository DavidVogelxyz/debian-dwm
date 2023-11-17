#!/bin/sh

################################
# VARIABLES
################################

fonts=(
"MesloLGS_NF_Regular.ttf"
"MesloLGS_NF_Bold.ttf"
"MesloLGS_NF_Italic.ttf"
"MesloLGS_NF_Bold_Italic.ttf"
)

pkgs=(
"curl"
"git"
"zsh"
)

################################
# FUNCTIONS
################################

changeshelltozsh() {
    echo "You will be asked for your password in order to change the default shell to zsh. Please enter your password now."
    chsh -s /usr/bin/zsh || exit 1
}

dependencychecks() {
    for pkg in "${pkgs[@]}"; do
        [ ! -e /usr/bin/$pkg ] && installcomment && needpkg="yes"
    done

    [[ $needpkg = "yes" ]] && exit 1
}

directorycheck() {
    [ ! -d /usr/local/share/fonts/m/ ] && sudo mkdir -p /usr/local/share/fonts/m/
    [ ! -d ~/.cache/zsh ] && mkdir -p ~/.cache/zsh
}

installcomment() {
    echo "'$pkg' is not yet installed on this computer. Please install '$pkg' before proceeding."
}

installfonts() {
    echo "There are $(echo ${#fonts[@]}) fonts to install. It shouldn't take long."
    echo "Elevated privileges are required to properly install the fonts. Please enter your password if asked."

    for font in "${fonts[@]}"; do
        webfont=$(echo $font | sed 's/_/%20/g')
        [ ! -e /usr/local/share/fonts/m/$font ] \
            && echo "now installing $font ..." \
            && sudo curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/$webfont -o /usr/local/share/fonts/m/$font > /dev/null 2>&1
    done
}

installpowerlevel10k() {
    [ ! -d ~/.local/src/powerlevel10k ] \
        && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/src/powerlevel10k > /dev/null 2>&1
}

################################
# ACTUAL SCRIPT
################################

dependencychecks

directorycheck

installfonts

installpowerlevel10k

changeshelltozsh
