#!/bin/bash

hitenter() {
  echo "Hit Enter when $1 is setup"
  read
}

cd ~

if [ -d ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs ]; then

  echo "> ssh key setup - needs iCLoud Setup"
  rsync -avz ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs/.ssh .
  chmod 600 ~/.ssh/*

  echo "> Comic Code Font"
  cp ${HOME}/Library/Mobile\ Documents/com~apple~CloudDocs/new_system/ComicCode* ${HOME}/Library/Fonts/

else
  echo "! No iCloud setup - not going to be able to run this script"
  exit 99
fi

echo "> Create ~/Repos"
mkdir Repos
cd Repos
git clone git@github.com:sixty4k/profile.git

cd profile/bin

echo "> Run Setup scripts from profile repo"
./defaults.sh
./setup_xcode_cli.sh
./homebrew.sh

echo "> Setup apps"

echo "> 1Password"
open "/Applications/1Password 7.app"
hitenter 1Password

echo "> Alfred"
echo "License key in 1Password"
open "$(ls -d /Applications/Alfred*)"
hitenter Alfred

echo "> iTerm"
echo "iCloud setting file is in iCloud Drive/Documents/AppSupport/iTerm"
echo "git saved version is in Repos/profile/configs/iTerm"
open "/Applications/iTerm.app"
hitenter iTerm

echo "> Sublime Text"
echo "Start App, input license from 1Pass, then setup saved config"
echo "Apparently my ST config is super fubar." 
open "/Applications/Sublime Text.app"
hitenter Sublime_Text

echo "> Amethyst"
open "/Applications/Amethyst.app"
hitenter Amethyst

echo "> Bash Profile"
curl -s https://raw.githubusercontent.com/sixty4k/profile/master/install | bash

