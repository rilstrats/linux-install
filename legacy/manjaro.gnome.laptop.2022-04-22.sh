#!/bin/bash

sudo pacman -Syu

sudo pacman -S brave-browser

# Open brave and set up settings sync and BitWarden

# Open GNOME Software and add AUR support

sudo pamac install megasync-bin 

# Sign into megasync
# Did this first to get access to the scripts 

sudo pacman -S arduino brave-browser discord gnome-keyring gparted libsecret seahorse signal-desktop

sudo pamac install git-credential-manager-core-bin megasync-bin slack-desktop visual-studio-code-bin zoom

# Need to add further instructions for arduino setup
sudo usermod -a -G uucp riley # Needed to access serial ports for arduino

# Might a good idea to restart at this point, should fix icons not appearing correctly
# Might need to manually fix code icon, it is located at /opt/visual-studio-code/resources/app/resources/linux/code.png
# Might need to manually fix slack icon, it is located at /usr/share/pixmaps/slack.png

# Git Setup
git-credential-manager-core configure
git config --global credential.credentialStore secretservice ; git config --global user.email "riley.s.stratton@outlook.com" ; git config --global user.name "Riley Stratton" ; git config --global color.ui auto

# Git Clone (should open browser to authenticate)
cd ; mkdir Git ; cd Git ; git clone https://github.com/RileyStratton/LinuxScripts.git

# Git Push (should work without manual authentication)
cd LinuxScripts ; echo date >> setup.txt ; git add . ; git commit -m "setup" ; git push

# Open timeshift and configure daily backups
# Open virtualbox and set default location to /run/media/riley/VM/VirtualBox and add all VMs
# Open VS Code and make sure settings sync works

# Surface Kernel
curl -s https://raw.githubusercontent.com/linux-surface/linux-surface/master/pkg/keys/surface.asc | sudo pacman-key --add -

sudo pacman-key --finger 56C464BAAC421453
sudo pacman-key --lsign-key 56C464BAAC421453

# Add these lines to /etc/pacman.conf
# [linux-surface]
# Server = https://pkg.surfacelinux.com/arch/

sudo pacman -Syu
sudo pacman -S linux-surface linux-surface-headers iptsd linux-firmware-marvell
sudo systemctl enable iptsd
sudo pamac install libwacom-surface

# restart

uname -a
# Confirmed that kernel is installed and that wifi worked

# Download MEGA file extension for nautilus

sudo pacman -S virtualbox vde2 virtualbox-ext-vnc virtualbox-guest-iso
# Specify the virtualbox host module for the kernel you are using (option 6 specified kernel 5.16 at time of writing)
sudo modprobe vboxdrv # Needed for virtualbox to work
sudo pamac install virtualbox-ext-oracle

# Create Kali and Metasploitable VMs
# Create Windows VM for Systems Security Class


