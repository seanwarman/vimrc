#!/bin/zsh

cat zshrc.defaults >> ~/.zshrc
brew install ranger git fzf bat docker vim the_silver_searcher
brew install --cask iterm2
touch ~/.vimrc
echo 'runtime vimrc' > ~/.vimrc

vim -c PluginBaby

echo 'Done! You can find the iterm profiles in the Profiles folder'
