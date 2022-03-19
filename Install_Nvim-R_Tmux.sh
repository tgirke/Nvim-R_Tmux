#!/bin/bash -l 

## Script to install Nvim-R_Tmux environemnt on HPCC 
## Author: Thomas Girke
## Date: 16-Mar-22
## User instructions are here: https://bit.ly/3CLzS41
## Note: this script needs to be run from within the cloned Install_Nvim-R_Tmux repos

## Check in run dir for existence of files/dirs to be created and later deleted 
if [ -f Nvim-R_Tmux.zip ] || [ -d Nvim-R_Tmux ]; then
    printf "File Nvim-R_Tmux.zip or directory Nvim-R_Tmux exist. Delete or rename them prior to runnng this script. \n"
    exit 0
fi

## Clone Install_Nvim-R_Tmux repos to your home on HPCC
# git clone git@github.com:tgirke/Nvim-R_Tmux.git
# cd Nvim-R_Tmux

## Copy the following files/dirs from Install_Nvim-R_Tmux and make backups of existing versions
## 1. .bashrc file
if [ -f ~/.bashrc ]; then
    mv ~/.bashrc ~/.bashrc_bak
fi
cp .bashrc ~/
echo "Moved new .bashrc file to home and created backup (~/.bashrc_bak) of existing one."

## 2. .tmux.conf file
if [ -f ~/.tmux.conf ]; then
    mv ~/.tmux.conf ~/.tmux.conf_bak
fi
cp .tmux.conf ~/
echo "Moved new .tmux.conf file to home and created backup (~/.tmux.conf_bak) of existing one."

## 3. .Rprofile file
if [ -f ~/.Rprofile ]; then
    mv ~/.Rprofile ~/.Rprofile_bak
fi
cp .Rprofile ~/
echo "Moved new .Rprofile file to home and created backup (~/.Rprofile_bak) of existing one."

## 4. .config directory
if [ ! -d ~/.config ]; then
    mkdir ~/.config 
fi
if [ -d ~/.config/nvim ]; then
    mv ~/.config/nvim ~/.config/nvim_bak
fi
cp -r .config/nvim ~/.config/
echo "Moved new .config/nvim directory to ~/.config and created backup (~/.config/nvim_bak) of existing one."

## 5. .local directory
if [ ! -d ~/.local ]; then
    mkdir ~/.local 
fi
if [ ! -d ~/.local/share ]; then
    mkdir ~/.local/share
fi
if [ -d ~/.local/share/nvim ]; then
    mv ~/.local/share/nvim ~/.local/share/nvim_bak
fi
cp -r .local/share/nvim ~/.local/share
echo "Moved new .local/share/nvim directory to ~/.local/share and created backup (~/.local/share/nvim_bak) of existing one."

## Clean-up
cd ..
rm -rf Install_Nvim-R_Tmux

## In case someone wants to undo changes here are some instructions
printf "To undo changes, run: \n\tcd ~/; mv .bashrc .bashrc_bak2; mv .bashrc_bak .bashrc; mv .tmux.conf .tmux.conf_bak2; mv .tmux.conf_bak .tmux.conf; mv .Rprofile .Rprofile_bak2; mv .Rprofile_bak .Rprofile; mv .config/nvim .config/nvim_bak2; mv .config/nvim_bak .config/nvim; mv .local/share/nvim .local/share/nvim_bak2; mv .local/share/nvim_bak .local/share/nvim\n"

