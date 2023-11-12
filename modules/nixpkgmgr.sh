#!/bin/sh

################################
# FUNCTIONS
################################

installnixpkgmgr() {
    sh <(curl -L https://nixos.org/nix/install) --daemon
}

################################
# ACTUAL SCRIPT
################################

installnixpkgmgr
