#!/bin/zsh
read -e -p "Enter an email or name for your ssh key:" email
ssh-keygen -t ed25519 -C "$email"
eval "$(ssh-agent -s)"
echo "Done! Copy your public key and add it to the repo"
