#!/bin/bash -l 

## Script to install nvim-R-tmux environemnt on HPCC 
## Author: Thomas Girke
## Date: 20-Apr-18
## User instructions are here: http://bit.ly/2vvqouy

## Check for existence of files/dirs to be created and later deleted 
if [ -f nvimRtmux.zip ] || [ -d nvimRtmux ]; then
    printf "File nvimRtmux.zip or directory nvimRtmux exist. Delete or rename them prior to runnng this script. \n"
    exit 0
fi

## Download and unzip this file to your home on biocluster
cd ~/
cp $(dirname $(realpath $0))/../share/nvimRtmux.zip .
unzip nvimRtmux.zip > /dev/null 2>&1

## Copy the following files/dirs from ~/nvimRtmux and make backups of existing versions
## 1. .bashrc file
if [ -f .bashrc ]; then
    mv .bashrc .bashrc_bak
fi
cp nvimRtmux/.bashrc .
echo "Moved new .bashrc file to home and created backup (.bashrc_bak) of existing one."

## 2. .tmux.conf file
if [ -f .tmux.conf ]; then
    mv .tmux.conf .tmux.conf_bak
fi
cp nvimRtmux/.tmux.conf .
echo "Moved new .tmux.conf file to home and created backup (.tmux.conf_bak) of existing one."

## 3. .Rprofile file
if [ -f .Rprofile ]; then
    mv .Rprofile .Rprofile_bak
fi
cp nvimRtmux/.Rprofile .
echo "Moved new .Rprofile file to home and created backup (.Rprofile_bak) of existing one."

## 4. .config directory
if [ -f .config ]; then
    mv .config .config_bak
fi
cp -r nvimRtmux/.config .
echo "Moved new .config directory to home and created backup (.config_bak) of existing one."

## Clean-up
#rm nvimRtmux.zip
#rm -rf nvimRtmux

## In case someone wants to undo changes here are some instructions
printf "To undo changes, run: \n\tmv .bashrc .bashrc_bak2; mv .bashrc_bak .bashrc; mv .tmux.conf .tmux.conf_bak2; mv .tmux.conf_bak .tmux.conf; mv .Rprofile .Rprofile_bak2; mv .Rprofile_bak .Rprofile; mv .config .config_bak2; mv .config_bak .config \n"

