#!/bin/sh

sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
sudo tee -a /etc/systemd/system/getty@tty1.service.d/override.conf &>/dev/null <<EOF

[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $USER --noclear %I 38400 linux

EOF
