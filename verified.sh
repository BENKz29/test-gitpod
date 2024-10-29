#!/bin/bash

#ENV
rm -rf scripts
sudo apt update && sudo apt upgrade -y
git clone https://github.com/akhilnarang/scripts
bash scripts/setup/android_build_env.sh

#SSH
cp -r /workspace/test-gitpod/.ssh /home/gitpod/
sudo chmod 600 ~/.ssh/id_ed25519
sudo chmod 600 ~/.ssh/id_ed25519.pub
sudo chmod 644 ~/.ssh/known_hosts
sudo chmod 755 ~/.ssh

#GPG
gpg --import secret-key-backup.asc
rm ~/.gnupg/trustdb.gpg
gpg --import-ownertrust < trustdb-backup.txt
git config --global commit.gpgsign true
git config --global credential.helper store
git config --global user.signingkey 9F9FE5E70F20E507
git config --global user.name "Kneba"
git config --global user.email "abenkenary3@gmail.com"

cat <<EOF >>/home/gitpod/.bash_profile
export VISUAL="nano"
export EDITOR="nano"
EOF

echo "export GPG_TTY=$(tty)" >> /home/gitpod/.bashrc

export GPG_TTY=$(tty)

source ~/.bash_profile
