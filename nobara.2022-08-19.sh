#!/bin/bash


# Update and Install
sudo dnf update -y
sudo dnf install -y wget discord ntfs-3g neovim zsh util-linux-user dnf-plugins-core
sudo flatpak install slack bitwarden spotify zoom signal


# Brave
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf -y install brave-browser
# Open brave and set up settings sync


# Drives
read -p 'Would you like to add the vm and game drives? [Y/n]: ' input
clean=`echo ${input:0:1} | tr '[:upper:]' '[:lower:]'`

if [[ $clean == 'n' ]]; then
    echo 'Drives not added'
else
    echo "UUID=29071D3603B7A859   /mnt/VM/      ntfs-3g    uid=1000,gid=1000,rw,user,exec,umask=000 0 0
    UUID=5A42FF7E42FF5D67   /mnt/Games/     ntfs-3g uid=1000,gid=1000,rw,user,exec,umask=000 0 0" | sudo tee -a /etc/fstab
    echo 'Drives added'
fi


# Code file structure
cd $HOME
mkdir code; cd code
mkdir src; cd src
mkdir github.com; cd github.com
mkdir rilstrats byui-csa


# Git
# Git Credential Manager
wget https://raw.githubusercontent.com/GitCredentialManager/git-credential-manager/main/src/linux/Packaging.Linux/install-from-source.sh
cat install-from-source.sh | sed "s/case \"\$distribution\" in/case \"fedora\" in/g" > install-from-source.fedora.sh
chmod +x install-from-source.fedora.sh
./install-from-source.fedora.sh
git-credential-manager-core configure

# Git Configure
git config --global credential.credentialStore secretservice
git config --global user.email "riley.s.stratton@outlook.com"
git config --global user.name "Riley Stratton"
git config --global color.ui auto
git config --global init.defaultBranch main
git config --global push.autoSetupRemote true

# Git Clone (should open browser to authenticate)
cd $HOME/code/src/github.com/rilstrats
git clone https://github.com/rilstrats/gcm-check.git

# Git Push (should automatically authenticate)
cd $HOME/code/src/github.com/rilstrats/gcm-check
date >> setup.txt
git add .
git commit -m "setup"
git push


# Mega
cd $HOME/Downloads
wget https://mega.nz/linux/repo/Fedora_36/x86_64/megasync-Fedora_36.x86_64.rpm
sudo dnf install ./megasync-Fedora_36.x86_64.rpm
mkdir $HOME/mega

if [[ "$XDG_CURRENT_DESKTOP" == "KDE" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/dolphin-megasync-Fedora_36.x86_64.rpm
    sudo dnf install ./dolphin-megasync-Fedora_36.x86_64.rpm
elif [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
    wget https://mega.nz/linux/repo/Fedora_36/x86_64/nautilus-megasync-Fedora_36.x86_64.rpm
    sudo dnf install ./nautilus-megasync-Fedora_36.x86_64.rpm
else
    echo "Unsupported Desktop Environment"
    echo "Please manually add File Manager Integration from https://mega.io/desktop"
fi
# Open mega and sign in


# .dotfiles clone
git clone --bare https://github.com/rilstrats/.dotfiles.git

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles.git --work-tree=$HOME'
alias dfs=dotfiles

dfs checkout -f
dfs submodule update

