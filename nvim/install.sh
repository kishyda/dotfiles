#!bin/sh

rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim

cd $HOME/.config

git clone https://github.com/kishyda/nvim.git /home/myuser/.config/nvim
