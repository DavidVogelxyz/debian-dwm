# debian-dwm

A derivation of Luke Smith's LARBS that works on Debian systems, with my added preferences.

I built some "module" bash scripts, tested them independently, and then created a "script of scripts" to run all the modules with one command.

Note: This script should be run as the primary local user for the computer; e.g., not as the root user.

```
apt update && apt install -y git
mkdir -pv ~/.local/src && cd ~/.local/src
git clone https://github.com/DavidVogelxyz/debian-dwm && cd ~/.local/src/debian-dwm
bash debian-dwm.sh
```

I imagine there are far better ways to build this installer. I plan to update this project as I learn them.
