#!/usr/bin/env bash

# packages
apps="git tmux irssi docker.io docker-compose"
base="wget curl ripgrep unzip jq ffmpeg build-essential"
c="clang clangd clang-format make cmake automake bear"
gui_apps="vlc galculator gparted keepassxc"
gui_utils="redshift redshift-gtk xclip fonts-jetbrains-mono"
sudo apt-get install -y $base $c $apps $gui_apps $gui_utils

# dirs & configs
mkdir -p ~/.local/bin
cp -r .irssi .config .tmux.conf ~
echo 'PATH=$PATH:~/.local/bin' >> ~/.bashrc
echo 'export VISUAL=nvim EDITOR=nvim' >> ~/.bashrc

# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# nodejs & npm packages
nvm install v20.16.0
npm i -g npm@latest
npm i -g typescript typescript-language-server vscode-langservers-extracted http-server prettier @johnnymorganz/stylua-bin

# nvim
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
rm nvim-linux64.tar.gz
sudo mv nvim-linux64 /var/opt/nvim
sudo ln -s /var/opt/nvim/bin/nvim /usr/local/bin
nvim +qall

# docker without sudo
sudo usermod -aG docker $USER

# git
git config --global user.name "okkiwan"
git config --global user.email "okkiwan@tuta.io"
ssh-keygen -t ed25519 -C "okkiwan@tuta.io" -f ~/.ssh/id_ed25519

# irssi
read -s -p 'libera password? ' liberapassword
sed -i "s/PASSWORD/$liberapassword/g" ~/.irssi/config
