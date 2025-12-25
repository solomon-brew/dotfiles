#!/bin/bash

# Atualização e instalação de pacotes necessários
sudo apt update
sudo apt upgrade -y

# Instala ferramentas de desenvolvimento
sudo apt install build-essential -y

# Instala pacotes necessários
sudo apt install zsh git bat xclip tmux direnv zoxide httpie neovim fastfetch gh fzf ripgrep fd-find tldr stow docker.io docker-compose cargo python3-dev pipx lazygit eza -y

# # Instalação do lazygit via PPA (descomente se desejar)
# sudo add-apt-repository ppa:lazygit-team/release -y
# sudo apt update
# sudo apt install lazygit -y

# Adiciona o usuário ao grupo docker
sudo usermod -aG docker $USER

# # Clona e instala o eza (descomente se eza não estiver disponível via apt)
# mkdir -p ~/downloads
# cd ~/downloads
# git clone https://github.com/eza-community/eza.git
# cd eza
# cargo install --path .
# cd ~

# Define o shell padrão como zsh
chsh -s /usr/bin/zsh $USER

# Configurações globais do git
git config --global init.defaultBranch main
git config --global user.email "ravic@ciandt.com"
git config --global user.name "Ravi Correia"
git config --global core.sshCommand "/mnt/c/Windows/System32/OpenSSH/ssh.exe"

# Clona o repositório de dotfiles e aplica as configurações
git clone git@github.com:ravicorreia/dotfiles
cd dotfiles
stow .
cd ~