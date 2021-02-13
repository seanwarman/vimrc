# My Vim Config

Clone the repo to your .vim folder:

```bash
git clone git@gitlab.com:cooldude3000/vim-config.git ~/.vim
```

Make a vimrc that looks for any file called vimrc:

```vim
" ~/.vimrc
runtime vimrc
```

Also make a tmux conf (and install tmux) and add it to your home:

```
source-file ~/.vim/tmux.conf
```

Open up vim, ignoring any errors, and run:

```
:PlugInstall
```

And you're ready to go!
