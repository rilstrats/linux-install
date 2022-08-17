#!/bin/bash

sudo apt update; sudo apt upgrade

sudo flatpak brave megasync

# Open brave and set up settings sync and BitWarden

sudo apt install steam code

sudo flatpak install signal discord zoom

# Git Setup
git-credential-manager-core configure
git config --global credential.credentialStore secretservice ; git config --global user.email "riley.s.stratton@outlook.com" ; git config --global user.name "Riley Stratton" ; git config --global color.ui auto

# Git Clone (should open browser to authenticate)
cd ; mkdir Git ; cd Git ; git clone https://github.com/RileyStratton/LinuxScripts.git

# Git Push (should work without manual authentication)
cd LinuxScripts ; echo date >> setup.txt ; git add . ; git commit -m "setup" ; git push

# Custom Surface Kernel
wget -qO - https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/linux-surface.gpg

echo "deb [arch=amd64] https://pkg.surfacelinux.com/debian release main" | sudo tee /etc/apt/sources.list.d/linux-surface.list

sudo apt update

sudo apt install linux-image-surface linux-headers-surface iptsd libwacom-surface

sudo systemctl enable iptsd

sudo update-grub

virtualbox virtualbox-ext-pack