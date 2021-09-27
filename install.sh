vim
ranger
git
nvm
brew
fzf
bat
oh-my-zsh
ssh for gitlab and github
iterm2 (with Profiles)
docker
Brave
clone weasel, weasel-adapter, nomcom, ucas-frontend-server, charcoal-blue, events-cms

and the following to your zshrc:

```
alias rnr="ranger"
alias gs="git status"
alias gc="git checkout"

# Checkout to a branch menu
alias fgc='git checkout $(git branch | fzf)'

# Delete multiple branches menu
alias fgd='git branch -d $(git branch | fzf -m)'

# Merge branch menu
alias fgm='git branch merge $(git branch | fzf)'

# Apply a stash menu
gitStashApply() {
  #           list stash       through fuzzy menu    only print the "stash@{n}" bit
  stashname=$(git stash list | fzf                 | awk -F : '{ print $1 }')
  # apply the stash name result
  git stash apply $stashname
}
# Set the function to an alias
alias fgs=gitStashApply

set -o vi
```
