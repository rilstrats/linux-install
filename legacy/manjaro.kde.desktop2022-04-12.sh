#!/bin/bash

sudo pacman -Syu

sudo pacman -S arduino brave-browser discord gnome-keyring gparted libsecret seahorse signal-desktop virtualbox vde2 virtualbox-ext-vnc virtualbox-guest-iso
# Specify the virtualbox host module for the kernel you are using (option 5 specified kernel 5.15 at time of writing)
sudo modprobe vboxdrv # Needed for virtualbox to work

sudo pamac install git-credential-manager-core-bin megasync-bin openrgb slack-desktop virtualbox-ext-oracle visual-studio-code-bin zoom

# Need to add further instructions for arduino setup
sudo usermod -a -G uucp riley # Needed to access serial ports for arduino

# Might a good idea to restart at this point, should fix icons not appearing correctly
# Might need to manually fix code icon, it is located at /opt/visual-studio-code/resources/app/resources/linux/code.png
# Might need to manually fix slack icon, it is located at /usr/share/pixmaps/slack.png

# Git Setup
git-credential-manager-core configure ; git config --global credential.credentialStore secretservice ; git config --global user.email "riley.s.stratton@outlook.com" ; git config --global user.name "Riley Stratton"

# Git Clone (should open browser to authenticate)
cd ; mkdir Git ; cd Git ; git clone https://github.com/RileyStratton/LinuxScripts.git

# Git Push (should work without manual authentication)
cd LinuxScripts ; echo date >> setup.txt ; git add . ; git commit -m "setup" ; git push


# Auto Mount
# Open /ect/fstab and add these two lines to the bottom (make sure to remove the comments/hashtags from beginning of line)
# UUID=29071D3603B7A859   /run/media/riley/VM/      ntfs    uid=1000,gid=1000,rw,user,exec,umask=000 0 0
# UUID=3E56C32256C2D9B3   /run/media/riley/Shared/  ntfs    uid=1000,gid=1000,rw,user,exec,umask=000 0 0

# Settings > Display Configuration > set Asus as left screen at 0,508
# Make eight virtual desktops and onfigure Pager to show application outlines
# Open vscode and sign in through GitHub, should open browser to authenticate
# Open brave browser, set as default, enable settings sync and configure BitWarden
# Open MEGA, sign in, set up full-sync
# Add icons to Git and Mega
# Open timeshift and configure daily backups
# Open virtualbox and set default location to /run/media/riley/VM/VirtualBox and add all VMs
