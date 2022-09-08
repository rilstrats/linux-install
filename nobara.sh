#!/bin/bash


# device (used to know if fstab or surface settings should be added)
while [[ "$device" != "desktop" && "$device" != "laptop" && "$device" != "other" ]]; do
    read -p "What device are you setting up? (DESKTOP, LAPTOP, or OTHER): " input
    device=`echo $input | tr '[:upper:]' '[:lower:]'`
    echo $device
done


# time
sudo timedatectl set-local-rtc 0
sudo timedatectl set-timezone America/Denver


# hostname
name="nobara-$device"
# read -p "What would you like to set the hostname to? " name
sudo hostnamectl hostname $name


# update and install
sudo dnf update -y
# packages already installed but needed to work: wget ntfs-3g
sudo dnf install -y alacritty discord neovim qemu virt-manager zsh dnf-plugins-core util-linux-user
sudo flatpak install slack bitwarden spotify zoom signal
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# brave
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
# sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf -y install brave-browser
# open brave and set up settings sync


# mega
mkdir $HOME/mega

cd $HOME/Downloads
wget https://mega.nz/linux/repo/Fedora_36/x86_64/megasync-Fedora_36.x86_64.rpm
sudo dnf install ./megasync-Fedora_36.x86_64.rpm

if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/dolphin-megasync-Fedora_36.x86_64.rpm
    sudo dnf install -y ./dolphin-megasync-Fedora_36.x86_64.rpm

elif [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/nautilus-megasync-Fedora_36.x86_64.rpm
    sudo dnf install -y ./nautilus-megasync-Fedora_36.x86_64.rpm
    
elif [[ "$XDG_CURRENT_DESKTOP" == "i3" || "$XDG_CURRENT_DESKTOP" == "XFCE" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/thunar-megasync-Fedora_36.x86_64.rpm
    sudo dnf install -y ./nautilus-megasync-Fedora_36.x86_64.rpm

else
    echo "Unsupported Desktop Environment"
    echo "Please manually add File Manager Integration from https://mega.io/desktop"
fi
# open mega and sign in


# code
mkdir -p $HOME/code/src/github.com/rilstrats $HOME/code/src/github.com/byui-csa


# fstab 
# read -p 'Would you like to add the vm and game drives? [Y/n]: ' input
# fstab=`echo ${input:0:1} | tr '[:upper:]' '[:lower:]'`

# if [[ $fstab == 'n' ]]; then
#     echo 'Drives not added'
# else

if [[ $device == 'desktop' ]]; then
    echo "UUID=29071D3603B7A859   /mnt/vm/      ntfs-3g    uid=1000,gid=1000,rw,user,exec,umask=000 0 0
    UUID=5A42FF7E42FF5D67   /mnt/games/     ntfs-3g uid=1000,gid=1000,rw,user,exec,umask=000 0 0" | sudo tee -a /etc/fstab
    echo 'Drives added'
fi


# wally (for moonlander keyboard)
if [[ $device == 'desktop' ]]; then
    sudo cp other/50-wally.rules /etc/udev/rules.d/50-wally.rules
    sudo groupadd plugdev; sudo usermod -aG plugdev $USER
fi


# surface
if [[ $device == 'laptop' ]]; then
    sudo dnf config-manager --add-repo=https://pkg.surfacelinux.com/fedora/linux-surface.repo
    sudo dnf install --allowerasing iptsd libwacom-surface
    sudo systemctl enable iptsd
    # also requires a reboot
fi


# .dotfiles 
cd $HOME
git clone --bare https://github.com/rilstrats/.dotfiles.git

/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME checkout -f
/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME submodule init
/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME submodule update

