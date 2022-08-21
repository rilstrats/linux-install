#!/bin/bash


# aliases (need to be set earlier as there was issues)
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dfs=dotfiles


# time and hostname
timedatectl set-local-rtc 0
timedatectl set-timezone America/Denver
read -p "What would you like to set the hostname to? " name
hostnamectl hostname $name


# update and install
sudo dnf update -y
# packages already installed but needed to work: wget ntfs-3g
sudo dnf install -y alacritty discord neovim virt-manager zsh dnf-plugins-core util-linux-user
sudo flatpak install slack bitwarden spotify zoom signal
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim


# brave
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf -y install brave-browser
# open brave and set up settings sync


# mega
cd $HOME/Downloads
wget https://mega.nz/linux/repo/Fedora_36/x86_64/megasync-Fedora_36.x86_64.rpm
sudo dnf install ./megasync-Fedora_36.x86_64.rpm
mkdir $HOME/mega

if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/dolphin-megasync-Fedora_36.x86_64.rpm
    sudo dnf install -y ./dolphin-megasync-Fedora_36.x86_64.rpm
elif [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/nautilus-megasync-Fedora_36.x86_64.rpm
    sudo dnf install -y ./nautilus-megasync-Fedora_36.x86_64.rpm
else
    echo "Unsupported Desktop Environment"
    echo "Please manually add File Manager Integration from https://mega.io/desktop"
fi
# open mega and sign in


# qemu/libvirt (unsure if necessary as VMs will run without)
# sudo dnf install qemu libvirt
# sudo systemctl enable libvirtd
# sudo systemctl start libvirtd


# fstab 
read -p 'Would you like to add the vm and game drives? [Y/n]: ' input
clean=`echo ${input:0:1} | tr '[:upper:]' '[:lower:]'`

if [[ $clean == 'n' ]]; then
    echo 'Drives not added'
else
    echo "UUID=29071D3603B7A859   /mnt/vm/      ntfs-3g    uid=1000,gid=1000,rw,user,exec,umask=000 0 0
    UUID=5A42FF7E42FF5D67   /mnt/games/     ntfs-3g uid=1000,gid=1000,rw,user,exec,umask=000 0 0" | sudo tee -a /etc/fstab
    echo 'Drives added'
    echo 
fi


# .dotfiles 
cd $HOME
git clone --bare https://github.com/rilstrats/.dotfiles.git

dfs checkout -f
dfs submodule init
dfs submodule update


# code
cd $HOME
mkdir code; cd code
mkdir src; cd src
mkdir github.com; cd github.com
mkdir rilstrats 


# git
# git-credential-manager
wget https://raw.githubusercontent.com/GitCredentialManager/git-credential-manager/main/src/linux/Packaging.Linux/install-from-source.sh
cat install-from-source.sh | sed "s/case \"\$distribution\" in/case \"fedora\" in/g" > install-from-source.fedora.sh
chmod +x install-from-source.fedora.sh
./install-from-source.fedora.sh
git-credential-manager-core configure

# git clone (should open browser to authenticate)
cd $HOME/code/src/github.com/rilstrats
git clone https://github.com/rilstrats/gcm-check.git

# git push (should automatically authenticate)
cd $HOME/code/src/github.com/rilstrats/gcm-check
date >> setup.txt
git add .
git commit -m "setup"
git push

