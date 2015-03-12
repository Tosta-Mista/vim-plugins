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
ST_NAME=supertab
IL_NAME=indentLine
PL_NAME=vim-powerline
CS_NAME=colorschemes
PATHOGEN="https://tpo.pe/pathogen.vim"
PWD=`pwd`
VIM=".vim"
VIMRC=".vimrc"
PLUGIN=$(echo ${HOME}/${VIM}/plugin)
AUTOLOAD=$(echo ${HOME}/${VIM}/autoload)
BUNDLE=$(echo ${HOME}/${VIM}/bundle)
COLORSH=$(echo ${HOME}/${VIM})
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
echo
rm -rf $PLUGIN/$ST_NAME
git clone https://github.com/ervandew/supertab.git $PLUGIN/$ST_NAME

echo
echo "---------------------------"
echo "| Install vim python-mode |"
echo "---------------------------"
echo
rm -rf $BUNDLE/$PM_NAME
git clone https://github.com/klen/python-mode.git $BUNDLE/$PM_NAME

echo
echo "----------------------"
echo "| Install indentLine |"
echo "----------------------"
echo
rm -rf $BUNDLE/$IL_NAME
git clone https://github.com/Yggdroot/indentLine.git $BUNDLE/$IL_NAME

echo
echo "-------------------------"
echo "| Install vim-powerline |"
echo "-------------------------"
echo
rm -rf $BUNDLE/$PL_NAME
git clone https://github.com/Lokaltog/vim-powerline.git $BUNDLE/$PL_NAME

echo
echo "----------------------------"
echo "| Install vim-colorschemes |"
echo "----------------------------"
echo
rm -rf $BUNDLE/$CS_NAME
git clone https://github.com/flazz/vim-colorschemes.git $BUNDLE/$CS_NAME

# Fix colorsheme when you use without pathogen 
# (error line 23).
cd $COLORSH
echo
echo 
rm -rf .git .gitignore README.md
git init 
git remote add origin https://github.com/flazz/vim-colorschemes.git
git pull origin master
cd $PWD

echo
echo
echo "Done!"
