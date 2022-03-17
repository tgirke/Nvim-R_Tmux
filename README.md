# Install_Nvim-R_Tmux

The following is a convenience install script to configure the Nvim-R-Tmux environment
described [here](https://gist.github.com/tgirke/7a7c197b443243937f68c422e5471899) in a 
user's home account. Note, the below [`Install_Nvim-R_Tmux.sh`](https://github.com/tgirke/Install_Nvim-R_Tmux/blob/main/Install_Nvim-R_Tmux.sh) 
script will activate custom config files/directories in a user's home account, including: 
`.bashrc`, `.tmux.conf`, `.Rprofile`, `.config/` and `.local/`. Thus, prior to executing 
`Install_Nvim-R_Tmux.sh` users want to make sure that they want these  changes performed 
in their home account. Instructions how to undo the changes, in case something goes wrong, 
are printed to the screen. Another alternative is to install the individual components
stepwise by executing the lines in `Install_Nvim-R_Tmux.sh` individually.

## Clone repos to your home directory

```sh
git clone git@github.com:tgirke/Install_Nvim-R_Tmux.git
```

## Install Nvim-R_Tmux environment

This installs the entire `Nvim-R_Tmux` environment into a users home account. 


```sh
cd Install_Nvim-R_Tmux
bash Install_Nvim-R_Tmux.sh
```
