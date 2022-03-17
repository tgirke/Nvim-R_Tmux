alias ll='ls -l'

# for new neovim and nvim-r
if [ -n "$MODULESHOME" ]; then
     module load neovim/0.6.0
     module load tmux/3.3
fi

## Call nvim with vim
alias vim=nvim
