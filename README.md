# Nvim-R-Tmux: Neovim-based IDE for R

+ Author: Thomas Girke
+ Last update: 16-Mar-2022
+ Note: this repos replaces old [Nvim-R-Tmux Tutorial](https://gist.github.com/tgirke/7a7c197b443243937f68c422e5471899) on Gist.

* * *

## Table of Content

1. [Overview](#overview)
2. [Installation](#intallation)
    1. [Quick install](#quickinstall)
    2. [Neovim](#neovim)
    3. [Tmux](#tmux) 
    4. [R package colorout](#colorout)
    5. [Nvim-R plugin](#nvimr)
    6. [NERDTree](#nerdtree)
    7. [Color scheme](#colorscheme)
    8. [Indentation guides](#indentguide)
    9. [Setup in user accounts of UCR's HPCC](#ucrhpcc)
3. [Usage and configuration](#usage)
    1. [Run R in built-in terminal emulator](#usage_nvim-r-split)
    2. [Run R in Tmux pane](#usage_tmux-split)
    3. [Basic NERDTree usage](#usage_nerdtree)
4. [Config files](#configfiles)
5. [Advanced topics](#advanced)
    1. [R version toggle](#rversion_toggle)
    2. [Install Neovim from source](#source_install_nvim) 
    3. [Install tmux from source](#source_install_tmux) 
    4. [Install pre-built R versions](#install_R)
    5. [Install R from source](#source_install_R)

* * *

<div id='overview'/>

## 1. Overview

This page gives an overview of the installation and usage of the new [Nvim-R](https://github.com/jalvesaq/Nvim-R) plugin from Jakson Alves de Aquino, the developer of the original vim-R plugin. The new plugin now also supports the new extension of Vim called [Neovim](https://neovim.io/). The main advantages of Neovim compared to Vim are its better performance and its built-in terminal emulator facilitating the communication among Neovim and interactive programming environments such as R. Since the Vim and Neovim environments are managed independently, one can run them in parallel on the same system without interfering with each other. The Nvim-R project page can be found [here](https://vim.sourceforge.io/scripts/script.php?script_id=2628) and its main manual is [here](https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/doc/Nvim-R.txt). The usage section below introduces how to use the plugin with or without Tmux. 

__Animated Screenshot of Nvim-R (from [here](https://github.com/jalvesaq/Nvim-R)):__
<center><img title="Nvim-R-Tmux" src="https://raw.githubusercontent.com/jalvesaq/Nvim-R/master/Nvim-R.gif" ></center> 


<div id='intallation'/>

## 2. Installation

<div id='quickinstall'/>

### 2.1 Quick install of Nvim-R-Tmux

The following provides a quick convenience install for configuring the
Nvim-R-Tmux environment in a user's home directory. This assumes that recent
versions of [Neovim](#neovim) and optionally [Tmux](#tmux) are already
pre-installed on a user's system. If this is not the case, then steps 2.2 (or
5.2) and 2.3 (or 5.3) need to be completed first. 

Note, executing the 
[`Install_Nvim-R_Tmux.sh`](https://github.com/tgirke/Nvim-R_Tmux/blob/main/Install_Nvim-R_Tmux.sh)
script as shown below will activate custom config files/directories in a user's home
directory, including: `.bashrc`, `.tmux.conf`, `.Rprofile`, `.config/` and
`.local/`. Prior to executing `Install_Nvim-R_Tmux.sh`, users want to make
sure that they want these  changes performed in their home account.
Instructions how to undo these changes, in case something goes wrong, are printed
to the screen. An alternative is to install the individual components stepwise
by executing the lines in
[`Install_Nvim-R_Tmux.sh`](https://github.com/tgirke/Nvim-R_Tmux/blob/main/Install_Nvim-R_Tmux.sh)
individually, or to proceed with the manual configuration outlined in the subsequent sections.

#### Clone repos to your home directory

```sh
git clone git@github.com:tgirke/Nvim-R_Tmux.git
```

#### Install Nvim-R_Tmux environment

This installs the entire `Nvim-R_Tmux` environment into a users home account. 


```sh
cd Nvim-R_Tmux
bash Install_Nvim-R_Tmux.sh
```

<div id='neovim'/>

### 2.2. Install Neovim for your OS 
Neovim Version >= 0.1.7 is required for Nvim-R. For the installation, follow the instructions [here](https://github.com/neovim/neovim/wiki/Installing-Neovim). A sample config file for controlling Neovim, called `init.vim`, is given [below](https://github.com/tgirke/Nvim-R_Tmux/blob/main/.config/nvim/init.vim). This or a similar `init.vim` file should be downloaded and saved to a user's home under `~/.config/nvim/init.vim`.

__Advanced__: for more advanced users it may often become important to install the latest Neovim version. For this it can be very useful to download Neovim from its [GitHub repos](https://github.com/neovim/), and then install it from source following these [instructions](#source_install_nvim). Using a package management software available on a user's system may be more convenient, but this will often only allow the installation of older Neovim versions. More detailed instructions for installing Neovim from source are given [below](#source_install_nvim).

<div id='tmux'/>

### 2.3. Install Tmux 
The usage of Tmux with Nvim-R is highly recommended on Linux or OS X systems but not absolutely necessary. Supported Tmux versions are >=2.0. To upgrade Tmux to a more recent version, one can follow the instructions [here](https://goo.gl/FssKpb). To install it from source, consult see intructions below [here](#source_install_tmux). If you get on Ubuntu 16.04 a `locale-gen en_US.UTF-8` error, then the last step [here](https://github.com/openwrt/packages/issues/2900) fixes it.  A sample config file for controlling Tmux, called `.tmux.conf`, is given [below](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/tmux.conf). This or a similar `.tmux.conf` file should be downloaded and saved to a user's home under `~/.tmux.conf`.

<div id='colorout'/>

### 2.4. Install R package `colorout` 
The R package `colorout` is available on GitHub [here](https://github.com/jalvesaq/colorout). If it is not yet installed in an R environment, one can install it from within R via the `devtools` package as follows: 

```sh
devtools::install_github("jalvesaq/colorout")
```

<div id='nvimr'/>

### 2.5. Install Nvim-R plugin for Neovim

#### 2.5.1 Manual install
Download the latest `*.vmb` from [here](https://vim8.org/scripts/script.php?script_id=2628). Then open the downloaded file with nvim (neovim), and then run from nvim's command mode the following commands:

```sh
:packadd vimball
:so %
# press space bar a few times until install is complete!
```

#### 2.5.2 Install with plugin manager
When new features become available in Nvim-R then one can get them immediately by installing the Nvim-R plugin from its [GitHub repos](https://github.com/jalvesaq/Nvim-R) directly. After downloading the repos, one can move its content (files and directories) manually to `~/.config/nvim` or install it with a Neovim plugin manager that includes GitHub support. The following uses `vim-plug` as plugin manager. After installing `vim-plug` for neovim as outlined [here](https://github.com/junegunn/vim-plug/wiki/tutorial) one can install plugins by listing them at the end of the `~/.config/nvim/init.vim` file as follows:

```sh
" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')                               
" Declare the list of plugins.                               
Plug 'jalvesaq/Nvim-R'                    
Plug 'preservim/nerdtree'
Plug 'jalvesaq/vimcmdline'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'lukas-reineke/indent-blankline.nvim'
" List ends here. Plugins become visible to Vim after this call.                          
call plug#end()        
```
After this, the vim commands `:PlugInstall`, `:PlugUpdate` and `:PlugClean` will install, update and remove plugins accordingly. Note, when using `vim-plug`, the `init.vim` config file remains under `.config/nvim` and the plugins will be installed under `~/.local/share/nvim/plugged/`. 

The version information for the Nvim-R plugin can be returned from vim's command mode as follows.

```sh
:help nvim-r
```

<div id='nerdtree'/>

### 2.6. Install NERDTree (optional)
Download the NERDTree vim plugin from [here](http://www.vim.org/scripts/script.php?script_id=1658). Then extract to `~/.config/nvim` with the following command. Note, if `vim-plug` is used as outlined [here](#nvimr) then Nerdtree will be installed automatically.

```sh
unzip NERD_tree.zip -d ~/.config/nvim
```

<div id='colorscheme'/>

### 2.7. Color Scheme (optional)
Jakson Alves de Aquino has developed the `southernlights` color scheme that works well with Nvim-R. To enable it, users want to save the file `southernlights.vim` from this [repos](https://github.com/jalvesaq/southernlights) to `~/.config/nvim/colors/` and add the recommended bash configurations to your `.bashrc` as described [here](https://github.com/jalvesaq/southernlights).  Note, this color scheme should be installed under `~/.config/nvim/colors/` even if a plugin manager is used that installs other plugins under `~/.local/share/nvim/plugged/`.

<div id='indentguide'/>

### 2.8. Indentation guides 
Vertical indentation lines (guides) are useful for tracking context in code. To enable indentation lines in nvim, one can use the [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) plugin. When using it the [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) plugin should also be installed. Both are included in the vim-plug install example above (see [2.5.2](#nvimr)). When nvim is configured with an `init.vim` file instead of `init.lua`, it is important to enclose lua parameter code (_e.g._ for indentation guides [here](https://github.com/lukas-reineke/indent-blankline.nvim)) in `init.vim` with the start/end tags given below. For details on `init.vim` and `init.lua`, see [here](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/). Note, when the plugin is installed, then the indentation guides show by default. To toggle them on/off, use `:IndentBlanklineToggle` or additional commands of this plugin starting with `Indent...`.


```sh
lua <<EOF
---lua lines
EOF
```

<div id='ucrhpcc'/>

### 2.9. Setup in user accounts of UCR's HPCC
Neovim and Tmux are already installed systemwide on the [HPCC](https://hpcc.ucr.edu/), but need to be loaded from the module system (step 1). What remains to be installed in each user's account are the plugins and configuration files as outlined below under steps 2-5. Alternatively, all required resources will be installed automatically by executing the command [`Install_Nvim-R_Tmux`](https://github.com/tgirke/Install_Nvim-R_Tmux) (old version was `install_nvimRtmux`) in a user's HPCC account.  

1. Add to your `.bashrc` the following lines

```sh
if [ -n "$MODULESHOME" ]; then
    module load neovim/0.6.0
    module load tmux/3.3
fi
```

2. Install Nvim-R plugin for Neovim as instructed [here](#nvimr)
3. Save this [`init.vim`](https://gist.githubusercontent.com/tgirke/7a7c197b443243937f68c422e5471899/raw/init.vim) sample file to `~/.config/nvim/init.vim`
4. Install NERDTree plugin as instructed [here](#nerdtree)
5. Install `southernlights` color scheme as instructed [here](#colorscheme)
6. Now log out of the system and in again. After this start tmux and then open a `.R` or `.Rmd` file with `nvim` command. Next open a connected R session with the key combination `\rf` and then follow the usage instructions given [here](#usage).

<div id='usage'/>

## 3. Usage and configuration

The usage of Neovim is almost identical to Vim. Two important differences are:

1. The command for opening Neovim is `nvim` instead of `vim`.
2. Plugins are usually stored under `~/.config/nvim/` and the counter part of the `.vimrc` config file is `init.vim` located at `~/.config/nvim/init.vim`.

<div id='usage_nvim-r-split'/>

### 3.1. Run R in built-in terminal emulator (preferred solution)

Open a `*.R` or `*.Rmd` file with `nvim` and intialize a connected R session with `\rf`. This command can be remapped to other key combinations, e.g. uncommenting lines 10-12 in `init.vim` will remap it to the `F2` key. Note, the resulting split window among Nvim and R behaves like a split viewport in `nvim` or `vim` meaning the usage of `Ctrl-w w` followed by `i` and `Esc` is important for navigation.

Important keybindings for nvim (vim):

- `\rf`: opens vim-connected R session (R version toggle is outlined [below](#rversion_toggle)) 
- `spacebar`: sends code from vim to R; here remapped in `init.vim` from default `\l`
- `:split` or `:vsplit`: splits viewport (similar to pane split in tmux)
- `gz`: maximizes size of viewport in normal mode (similar to Tmux's `Ctrl-a z` zoom utility) 
- `Ctrl-w w`: jumps cursor to R viewport and back; toggle between insert (`i`) and command (`Esc`) mode is required for navigation and controlling the environment.
- `Ctrl-w r`: swaps viewports
- `Ctrl-w =`: resizes splits to equal size
- `Ctrl-w 5< or 5>`: resizes splits to left or right by 5 steps; change number as needed
- `Ctrl-w H` or `Ctrl-w K`: toggles between horizontal/vertical splits
- `Ctrl-spacebar`: omni completion for R objects/functions when nvim is in insert mode. Note, this has been remapped in `init.vim` from difficult to type default `Ctrl-x Ctrl-o`. 
- `:h nvim-R`: opens nvim-R's user manual; navigation works the same as for any Vim/Nvim help document
- `:Rhelp fct_name`: opens help for a function from nvim's command mode with text completion support
- `Ctrl-s and Ctrl-x`: freezes/unfreezes vim (some systems)

<div id='usage_tmux-split'/>

### 3.2. Run R in Tmux pane (historical solution)

To run R in a separate Tmux pane, include the following two lines in your `init.vim`. Note: with Neovim's built-in terminal emulator this option is not so important anymore, since Neovim's vim-r split is more robust and feature-rich. To incorporate the features of a terminal multiplexer like Tmux, one simply runs the environment within a Tmux session, where the vim-r splits are handled by Neovim rather than Tmux. Yet, running R in a sparate Tmux pane is still possible as outlined below.

    - `let R_in_buffer=0`
    - `let R_tmux_split=1`

Open a `*.R` or `*.Rmd` file with `nvim` and start R with `\rf`. Similarly as above, the `\rf` command can be remapped to other key combinations, e.g. uncommenting three lines containing `F2` in `init.vim` will remap it to the `F2` key. To navigate among the Nvim and R panes, the key combination `Ctrl-w-o` is important. 

Important keybindings for Tmux panes:

- `Ctrl-a o`: jumps cursor to next pane e.g. from Nvim to R console pane
- `Ctrl-a Ctrl-o`: swaps panes
- `Ctrl-a z`: maximizes (zooms into) active pane
- `Ctrl-a d`: detaches from current session
- `tmux a`: attaches to tmux session
- `tmux attach -t <id>`: attaches to specific tmux session


Note, closing R in this setup will also close the corresponding Tmux pane. This is different from the behavior of the older vim-R plugin where the R pane stayed open and returned a shell after quitting R. This behavior can be useful to open a different R version or ssh into remote systems while maintaining the connected Nvim pane from where code can still be sent to the original pane. To achieve a similar behavior with the new Nvim-R plugin, one can use the following workaround: 

1. Switch cursor scope to R esssion (with `Ctrl-a o`) and then execute from R pane `system("tmux set remain-on-exit on")`
2. Quit R with `q()`. This gives a dead pane that can be reactivated by starting a shell in it with the commands `Ctrl-a` and `:respawn-pane bash`

<div id='usage_nerdtree'/>

### 3.3. Basic NERDTree usage

Important key bindings for NERDTree usage:

- `zz or :NERDTreeToggle`: opens NERDTree ('zz' requires corresponding setting in [.config/nvim/init.vim](https://github.com/tgirke/Nvim-R_Tmux/blob/main/.config/nvim/init.vim))
- `:NERDTreeFind`: finds current file in tree
- `?`: opens NERDTree help
- `I` (`shift` `i`): toggle between showing and hiding hidden files/directories
- `q`: closes NERDTree
- `Ctrl-w-w`: jump cursor to next viewport including the one for NERDTree
- `o or <enter>`: opens selected file
- `t`: opens file in new tab
- `gt and gT`: switches between tabs
- `i`: opens file with horizontal split
- `s`: opens file in vertical split
- `m`: opens menu mode for creating/deleting files, `Ctrl-c` exits out of this mode
- `B`: shows bookmarks
- `:Bookmark <name>`: creates bookmark for selected tree branch
- `D`: deletes selected bookmark

<div id='configfiles'/>

## 4. Config files
The following config files (or similar custom versions) should be saved to the following locations in a user's home directory:

- File [init.vim](https://github.com/tgirke/Nvim-R_Tmux/blob/main/.config/nvim/init.vim) for Neovim: `~/.config/nvim/init.vim`
- File [tmux.conf](https://github.com/tgirke/Nvim-R_Tmux/blob/main/.tmux.conf) for Tmux: `~/.tmux.conf`

<div id='advanced'/>

## 5. Advanced topics

This section is only relevant for advanced users who require a high level of customization, _e.g._ for R package development.

<div id='rversion_toggle'/>

### 5.1. R version toggle

Different R versions installed on a system can be loaded via specific
keybinding in Nvim-R. The example below loads one of two R versions (_e.g._ R-release 
or R-development) with the keybindings `\r1` or `\r2`, respectively. With a Tmux pane split 
both R versions can be loaded in a single terminal window simultaneously. 

__Screenshot of two different R versions loaded in one terminal window:__
<center><img title="Nvim-R-Tmux" src="https://raw.githubusercontent.com/tgirke/my_gist_images/master/Nvim-R-Tmux/nvim-version-toggle.png" ></center>


Note, the R version keybinding toggle was added by Jakson Alves de Aquino in April-2020. 
To obtain this feature, one needs to first download an Nvim-R version from Github 
([here](https://github.com/jalvesaq/Nvim-R)) from April-2020 or later, and then 
move it to `~/.config/nvim`, or use a Neovim plugin manager with GitHub support. 
Subsequently, the following lines need to be added to the `~/.config/nvim/init.vim` 
file where `\r1` and `\r2` can be customized as needed, and the associated paths need to point to 
the corresponding R load bash scripts installed on a system. Currently, the latter 
need to be named explicitly 'R' to work with Nvim-R. To allow calling specific R 
versions from the command-line (outside of Nvim), one can use an alias in `~/.bashrc`. 
For instance, include the following alias setting to open R's development version by typing 
`R-dev` on the command-line: `alias R-dev='/usr/local/lib/R-devel/bin/R'`. Optionally, one can also provide
a custom path for packages installed in a user's home directory like this: `alias R-dev='R_LIBS_USER=R_LIBS_USER=~/R/%p-library/%v_<my_subdir> /usr/local/lib/R-devel/bin/R'`. The latter can be important for managing several Bioconductor versions that use the same R version (see [here](https://cran.r-project.org/web/packages/BiocManager/vignettes/BiocManager.html#multiple-versions) for additional details).


Lines to include in `init.vim`:

```sh
function StartRFromPath(path)
    let g:R_path = a:path
    let $R_LIBS_USER='~/R/%p-library/%v' " default path for packages installed in a user's home directory
    call StartR("R")
endfunction

nmap \r1 :call StartRFromPath('/usr/bin')<CR>
nmap \r2 :call StartRFromPath('/usr/local/lib/R-devel/bin/')<CR>
```

To manage several Bioconductor versions for the same R version, one can define two or more R start up functions, _e.g._ one for release (`StartRFromPath`) and one for development (`StartRdevFromPath`), where `R_LIBS_USER` is assigned the corresponding path for packages installed in a user's home directory, _e.g._ `~/R/%p-library/%v_Bioc3.14` for development version.

Note, one can also load specific R versions manually by enabling 
one of the following two lines. The first one is enabled here in combination 
with the above R version toggle to allow loading of the default R version 
with Nvim-R's default keybinding `\rf` if that version's load script is located
in `/usr/bin/`.

```vi
let R_path = '/usr/bin/' "to load default R (here release)
"let R_path = '/usr/local/lib/R-devel/bin/' "to load R-development
```

<div id='source_install_nvim'/>

### 5.2. Install Neovim from source

General instructions for installing Neovim from source are available [here](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source). The corresponding prerequisites for
the install are outlined [here](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites). 

The following provides additional details that were required for installing the latest Neovim on Debian/Stretch, Debian/Buster and Ubuntu/18.04 systems (here nvim v0.5.0). Installs on other Linux systems will be similar, but the required dependency packages added in the first step may differ. The best way to find out is to install according to 
the official instruction guidelines [here](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-source),
and then address the depencies according to possible warning and/or error messages occuring during the install. 

__1.__ Install dependencies

```sh
sudo apt install cmake clang libtool libtool-bin libboost-all-dev gettext
```

__2.__ Download latest Neovim from GitHub

```sh
git clone https://github.com/neovim/neovim.git
```

__3.__ Build Neovim from source (paths below install into `~/bin`)

```sh
cd neovim
rm -r build/ # clear the CMake cache if 'build' is present from previous install                                  
make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/bin/neovim"                                                
make install
```

__4.__ Include these lines in your `.bashrc` to load custom built Neovim with `vim` or `nvim`                                 

```sh
export PATH="$HOME/bin/neovim/bin:$PATH"
alias vim=nvim
```

__5.__ Now open Neovim and check from command mode its version

```sh
:version # type from command mode
NVIM v0.5.0-427-g1f56f9a4b # first returned line from 9-Apr-2020 install
```

<div id='source_install_tmux'/>

### 5.3. Install tmux from source 

Use the following steps to build and install tmux from source on Debian and/or Ubuntu. These instructions are derived from [here](https://gist.github.com/P7h/91e14096374075f5316e#file-tmux__ubuntu__build_from_source-sh).

```sh
cd ~/bin # optional step to manage custom installs under ~/bin
VERSION=3.3-rc # select tmux version to install from here: https://github.com/tmux/tmux/releases
sudo apt-get -y remove tmux
sudo apt-get -y install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
tar xf tmux-${VERSION}.tar.gz
rm -f tmux-${VERSION}.tar.gz
cd tmux-${VERSION}
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${VERSION} /usr/local/src
```

<div id='install_R'/>

### 5.4. Install pre-built R versions

Current and historical versions of R can be downloaded for all common operating systems from CRAN [here](https://cran.r-project.org/bin/). Install instructions via binaries and OS specific package managers are given in the corresponding OS specific subdirectories of the same page. This is usually the preferred install solution for most users. 

A basic workflow for installing and upgrading to a specific version of R (here for R-4.0.x under Debian Buster) would look like this. First, add the following line to your `/etc/apt/sources.list` file: `deb http://cloud.r-project.org/bin/linux/debian buster-cran40/`. If not available yet, add the proper key to your keyserver. For example: `sudo apt-key adv --keyserver keys.gnupg.net --recv-key 'E19F5F87128899B192B1A2C2AD5F960A256A04AF'` Next, run these commands, where the first two lines will install some typical dependencies. For additional details, open the CRAN instructions for installing R for your specific operating system [here](https://cran.r-project.org/bin/linux/).

```sh
sudo apt install libcurl4-openssl-dev
sudo apt-get install libcurl4-openssl-dev
sudo apt update
sudo apt upgrade
# sudo apt install -t buster-cran40 r-base r-base-dev # run this line if previous one doesn't trigger R install
```

Now continue under section 5.4.5 with the installation of important dependencies and R packages.  

<div id='source_install_R'/>

### 5.5. Install R from source

Instructions for installing R from source are provided in the corresponding install manuals from [CRAN](https://cran.r-project.org/manuals.html) and [RStudio](https://docs.rstudio.com/resources/install-r-source/). Source installs are mainly relevant for R package development routines to test code on specific R versions (_e.g._ development version). Typical R users not involved in package development may not need this and can follow the instructions linked under [installing pre-built R versions](#install_R).

The following outlines how to install any R version from source on Debian/Ubuntu systems. The given example 
installs the latest R development version after downloading it via `svn` or `ftp/http`. For comparison, a similar but not identical R source install setup by a user is described [here](http://singmann.org/installing-r-devel-on-linux/).

__1.__ Install dependencies (these may be installed already)                                            

```sh
sudo apt install r-base r-base-dev \
    subversion \ 
    ccache \
    xorg-dev \
    default-jdk \
    libx11-dev \
    libcurl4-openssl-dev
```

__2.__ Download R source via `svn` or `ftp/http` from the corresponding [source download page](https://stat.ethz.ch/R/daily/), and save it to a target directory. The below `svn` command downloads the development version of R from `trunk`, and saves it to a directory called `R-devel`. The latter directory name can be customized as needed. An advantage of the `svn` download appoach is that it makes it easier to keep up with future incremental version updates during a develpment/release cycle. The R version options downloadable via `svn` can be looked up here: [https://svn.r-project.org/R/](https://svn.r-project.org/R/).

```sh
mkdir ~/svn                                   
cd ~/svn 
svn co https://svn.r-project.org/R/trunk R-devel # downloads developer version of R from trunk

## Alternatively, look up latest R version and download it
# wget ftp://ftp.stat.math.ethz.ch/Software/R/R-devel_yyyy-mm-dd.tar.gz                                            
# gunzip R-devel_yyyy-mm-dd.tar.gz; tar -xvf R-devel_yyyy-mm-dd.tar
```

__3.__ Build and install R

The following will build and install the R source stored under `~/svn/R-devel` in `/usr/local/lib/R-devel`. The latter path is defined under '`--prefix`' below. This path can be changed to the desired install location on a system. For instance, installing R under `/opt/` or in a user account under `~/bin/` would be common alternative locations. When installing it in your own user account, then drop `sudo` in the corresponding command(s) below. For tracking purposes it may be most convenient to generate for the below install commands a `*.sh` script named after a specific R version install (_e.g._ R_devel_4_1.sh). This way it will be easier to customize and track the install commands used for each instance of an R source install. 

```sh
mkdir ~/svn/R-devel-build # in case of svn build in dedicated directory 
cd ~/svn/R-devel-build
../R-devel/configure \
    --prefix=/usr/local/lib/R-devel \
    --enable-R-shlib \
    --enable-BLAS-shlib \
    --enable-shared \
    --enable-static \
    --with-blas \
    --with-lapack \
    --with-libpng \
    --with-jpeglib \
    --with-cairo \
    --with-x \
    --without-recommended-packages

make
sudo make install  
```
Troubleshooting: if you get under `make` an error like `libR.so: undefined reference to drot_` (_e.g._ on Ubuntu 18.04) then drop in `configure` the line:`--with-blas`. Most likely OpenBlas was already installed via `sudo apt install lipopenblas-base`. In this case the default OpenBlas will be used on a system. 

To update the R development version via svn, run the following update steps, and then re-run under the `~/svn/R-devel-build` directory the install of the previous code box.

```sh
cd ~/svn/R-devel
svn update
./tools/rsync-recommended
```

To check which optional features have been enabled for building R, one can do this from within R with:

```r
capabilities()
```

__4.__ Starting specific R versions

Add the following alias definition lines to your `~/.bashrc` file. The first two lines may be optional if it is the default setting in a user's `$PATH`.  

```sh
alias R='/usr/bin/R' 
alias Rscript='/usr/bin/Rscript' 
alias R-dev='/usr/local/lib/R-devel/bin/R'
alias Rscript-dev='/usr/local/lib/R-devel/bin/Rscript'
```

Now, one can load the release or development versions of R by typing on the command-line `R` or `R-dev`, respectively. In addition, the same R versions are called with `Rscript` and `Rscript-dev`, respectively.      

__5.__ Install common system dependencies 

This installs a variety of system dependencies that are required by many R packages. Note, the `texlive-full` package is 
very large (5.2GB). If disk space is limited then one may want to skip its install or just install `texlive` instead (270MB).

```sh
sudo apt install build-essential \
    libcurl4-gnutls-dev \
    openjdk-7-* \
    libxml2-dev \
    libssl-dev \
    texlive-full \
    librsvg2-dev \
    libcairo2-dev \
    libxt-dev \ 
    libgsl-dev
```

For R Markdown one will need to have the command-line tool `pandoc` installed. On Debian/Ubuntu systems it can be installed via `apt get install pandoc pandoc-citeproc`. Alternatively, installing RStudio will include a pandoc version recommended by R Markdown. If command-line R cannot locate RStudio's pandoc version, then one can set the proper path in any R/Rmd script or in a user's .Rprofile file with `Sys.setenv(RSTUDIO_PANDOC="<insert_path>")`. The path (here `<insert_path>`) can be identified by running from RStudio: `Sys.getenv("RSTUDIO_PANDOC")`.


__6.__ Install common R packages

The R package collection `devtools` is required for many development tasks including the install of other R packages from GitHub directly. In addition, `tidyverse` is a collection of packages that are often required for many routine tasks, including `ggplot2`, `dplyr` and [more](https://www.tidyverse.org/packages/).

Run the following package installs from R.

```r
install.packages(c("devtools", "tidyverse"))
```                                                                                                           

Now install Bioconductor's package manager from R.

```r
if (!requireNamespace("BiocManager", quietly = TRUE)) 
    install.packages("BiocManager")  
BiocManager::install()
```

After this one can install Bioconductor packages from R as follows.

```r
BiocManager::install(c("GenomicFeatures", "AnnotationDbi"))
```

The Bioconductor version can be returned with this command.

```r
BiocManager::version()
```

For additional details see Bioconductor's package [install page](https://bioconductor.org/install/).


__7.__ Simple uninstall 

To remove the above R source installation, one can simply remove the following directories.

```sh
/usr/local/lib/<R-devel>
~/R/x86_64-pc-linux-gnu-library/<X.X> # Present when R packages were installed in user's home  
```

__8.__ Troubleshooting

__a.__ Graphics: X11 font problem 

If certain R graphics libraries, such as `ggplot2` or `lattice`, return X11 font problems (like 'X11 font -adobe-helvetica ... not found'), then it may be necessary to include the following or a similar X11 default setting in your `~/.Rprofile` file. For additional details on this issue, these user postings may be helpful: [post1](https://bit.ly/2Vf9XNZ) and [post2](https://bit.ly/3eo4OKW). Note, the last line, `options(bitmapType = 'cairo')`, is necessary to address this `rmarkdown::render()` [issue](https://github.com/rstudio/rmarkdown/issues/1100). Alternatively, for building R Markdown vignettes, this line can be included at the beginning of a vignette's YAML header under parameter: `vignette:`.

```r
# default X11() setting
setHook(packageEvent("grDevices", "onLoad"),
	function(...) grDevices::X11.options(width = 8, height = 8, xpos = 0, pointsize = 10, type = "cairo"))
options(bitmapType = 'cairo')
```

On shared user systems, one can define these settings system-wide by including them in an `Rprofile.site` file under `file.path(R.home(), "etc/Rprofile.site")`. The content in the `Rprofile.site` file could look like this:

```r
local({                                   
   setHook(packageEvent("grDevices", "onLoad"),
   function(...) grDevices::X11.options(type='cairo'))                             
   options(device='x11')                                                  
})
```
Additinal details on this is available in R's main documentation [here](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html). 

__b.__ ...

...


