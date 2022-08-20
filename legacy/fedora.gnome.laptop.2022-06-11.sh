# OMZ
sudo dnf install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Open .zshrc and set ZSH_THEME="agnoster"

# Brave
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
# Open brave and set up settings sync

# Mega
# Download both megasync and nautilus extension from https://mega.io/desktop
cd Downloads
sudo dnf install ./mega...
sudo dnf install ./nautilus...
cd
# Open mega and sign in

# Surface Kernel
sudo dnf config-manager --add-repo=https://pkg.surfacelinux.com/fedora/linux-surface.repo
sudo dnf install --allowerasing kernel-surface kernel-surface-devel iptsd libwacom-surface surface-secureboot
sudo systemctl enable iptsd

sudo echo '[Unit]
Description=Fedora default kernel updater

[Path]
PathChanged=/boot

[Install]
WantedBy=default.target' > /etc/systemd/system/default-kernel.path

sudo echo '[Unit]
Description=Fedora default kernel updater

[Service]
Type=oneshot
ExecStart=/bin/sh -c "grubby --set-default /boot/vmlinuz*surface*"' > /etc/systemd/system/default-kernel.service

sudo systemctl enable default-kernel.path
sudo grubby --set-default /boot/vmlinuz*surface*
# Restart the computer

# Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install code
# Open VS Code and set up settings sync

# Git Credential Manager
cd
mkdir Git
cd Git
curl -LO https://raw.githubusercontent.com/GitCredentialManager/git-credential-manager/main/src/linux/Packaging.Linux/install-from-source.sh
chmod +x install-from-source.sh
./install-from-source.sh
git-credential-manager-core configure

# Git Configure
git config --global credential.credentialStore secretservice
git config --global user.email "riley.s.stratton@outlook.com"
git config --global user.name "Riley Stratton"
git config --global color.ui auto

# Git Clone (should open browser to authenticate)
git clone https://github.com/RileyStratton/LinuxScripts.git

# Git Push (should work without manual authentication)
cd LinuxScripts
echo date >> setup.txt
git add .
git commit -m "setup"
git push


# Virualbox
# Download binary from virtualbox website 
sudo dnf install Virtual...
