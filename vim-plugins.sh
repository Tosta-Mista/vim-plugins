#!/bin/bash
#
# Copyright 2015 Dimitris Zlatanidis <d.zlatanidis@gmail.com>,
# José Gonçalves <jose.goncalves@dlcproduction.ch> (modification)
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
# EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# This is a simple bash script that installs vim plugins:
# python-mode
# indentLine 
# supertab
# vim-powerline
# vim-colorschemes

# Requirements:
# vim >= 7.3 + Python or Python3

# Installation requirements as usually found 
# in all unix-like systems:
# GNU wget
# Git
# awk

PM_NAME=python-mode
GO_NAME=vim-go
ST_NAME=supertab
IL_NAME=indentLine
CS_NAME=colorschemes
PATHOGEN="https://tpo.pe/pathogen.vim"
PWD=`pwd`
VIM=".vim"
VIMRC=".vimrc"
PLUGIN=$(echo ${HOME}/${VIM}/plugin)
AUTOLOAD=$(echo ${HOME}/${VIM}/autoload)
BUNDLE=$(echo ${HOME}/${VIM}/bundle)
COLORSH=$(echo ${HOME}/${VIM})
PIP=$(which pip3)
set -e

# create directories if not exists
echo "Create directories..."
mkdir -p $VIM $AUTOLOAD $BUNDLE $PLUGIN

echo
echo "------------------------------------"
echo "|             S T A R T            |"
echo "------------------------------------"
echo

# copy my vimrc
cat vimrc >> $HOME/$VIMRC

# install pathogen only if new file exists
echo
echo "------------------------"
echo "| Install pathogen.vim |"
echo "------------------------"
echo
wget -N --directory-prefix=$AUTOLOAD $PATHOGEN
# enable pathogen
cat enable_pathogen >> $HOME/$VIMRC

# removes duplicate lines from .vimrc
awk '!x[$0]++' $HOME/$VIMRC > $HOME/$VIMRC.NEW
mv $HOME/$VIMRC.NEW $HOME/$VIMRC

echo
echo "--------------------"
echo "| Install supertab |"
echo "--------------------"
rm -rfv $PLUGIN/$ST_NAME
git clone https://github.com/ervandew/supertab.git $PLUGIN/$ST_NAME
echo

echo "---------------------------"
echo "| Install vim python-mode |"
echo "---------------------------"
rm -rfv $BUNDLE/$PM_NAME
git clone --recurse-submodules https://github.com/python-mode/python-mode $BUNDLE/$PM_NAME
echo

echo "---------------------------"
echo "| Install vim Go plugin   |"
echo "---------------------------"
rm -rfv $BUNDLE/$GO_NAME
git clone https://github.com/fatih/vim-go.git $BUNDLE/$GO_NAME
echo

echo "----------------------"
echo "| Install indentLine |"
echo "----------------------"
rm -rfv $BUNDLE/$IL_NAME
git clone https://github.com/Yggdroot/indentLine.git $BUNDLE/$IL_NAME
echo

echo "-------------------------"
echo "| Install vim-powerline |"
echo "-------------------------"
sudo apt install python3-pip python3-dev build-essential
$PIP install setuptools
$PIP install powerline-status
echo "set rtp+=/usr/local/lib/python3.5/dist-packages/powerline/bindings/vim/" | sudo tee -a /etc/vim/vimrc
echo "Install powerline fonts"
if [ -f "fonts/install.sh" ]; then
    echo "Powerline fonts already exists."
else 
    git clone https://github.com/powerline/fonts.git
    fonts/install.sh
fi
echo

echo "----------------------------"
echo "| Install vim-colorschemes |"
echo "----------------------------"
rm -rf $BUNDLE/$CS_NAME
git clone https://github.com/flazz/vim-colorschemes.git $BUNDLE/$CS_NAME
echo

echo "Done!"
