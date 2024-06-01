#!/bin/sh

################################
# FUNCTIONS
################################

installpkgs() {
    while read pkg; do
        echo "Installing '$pkg' now..."
        sudo apt install $pkg -y >/dev/null 2>&1
    done < package-list
}

################################
# ACTUAL SCRIPT
################################

installpkgs
