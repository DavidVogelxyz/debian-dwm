#!/bin/sh

nix-env -iA nixpkgs.librewolf && sudo ln -s $(echo $(whereis librewolf | awk '{print $2}')) /usr/bin/librewolf
