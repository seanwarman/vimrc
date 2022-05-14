touch ~/.tmux.conf
echo 'source-file $HOME/.vim/tmux.conf' > ~/.tmux.conf
touch ~/.vimrc
echo 'runtime vimrc' > ~/.vimrc
cp .gotty ~/.gotty
echo 'export TERM=xterm-256color' >> ~/.bashrc

sudo apt-get update
sudo apt-get install mp3gain
