# My Vim Config

This repo also acts like a dotfile repo for my work macbook.

Run the install scripts:

```sh
./install-one.sh
./install-two.sh
```

Note. If they don't work you might have to do `chmod +x`
on them.

Run the ssh scripts, how ever many times you need to:

```sh
./ssh.sh
```

Clone the repo to your .vim folder:

```sh
git clone git@gitlab.com:cooldude3000/vim-config.git ~/.vim
```

Make a vimrc that looks for any file called vimrc:

```vim
" ~/.vimrc
runtime vimrc
```

Your bookmarks arte in **Bookmarks**, and your iTerm2 profiles
(colours etc) are in **Profiles**.

There's a ranger config as well, I think you can put that into
*~/.config* on a mac like on linux.
