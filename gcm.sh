#!/bin/bash

# git-credential-manager
cd $HOME
wget https://raw.githubusercontent.com/GitCredentialManager/git-credential-manager/main/src/linux/Packaging.Linux/install-from-source.sh
cat install-from-source.sh | sed "s/case \"\$distribution\" in/case \"fedora\" in/g" > install-from-source.fedora.sh
chmod +x install-from-source.fedora.sh
./install-from-source.fedora.sh
git-credential-manager-core configure

# git clone (should open browser to authenticate)
cd $HOME
git clone https://github.com/rilstrats/gcm-check.git

# git push (should automatically authenticate)
cd $HOME/gcm-check
date >> setup.txt
git add .
git commit -m "setup"
git push
