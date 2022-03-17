alias ll='ls -l'

# modules definitions
if [ -n "$MODULESHOME" ]; then
  module load vim
fi

# for new neovim and nvim-r
if [ -n "$MODULESHOME" ]; then
     module load neovim
     module load tmux/2.2
fi

## Call nvim with vim
alias vim=nvim
