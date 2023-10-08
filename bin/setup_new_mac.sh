#!/bin/bash

hitenter() {
  echo "Hit Enter when $1 is setup"
  read
}

cd ~

mkdir Repos

rsync -avz /Users/mrobinson/Library/Mobile\ Documents/com~apple~CloudDocs/.ssh .
chmod 600 ~/.ssh/*

cd Repos
git clone git@github.com:sixty4k/profile.git

cd profile/bin

./defaults.sh
./setup_xcode_cli.sh
./homebrew.sh

echo "> Setup apps"

echo "> 1Password"
open "/Applications/1Password 7.app"
hitenter 1Password

echo "Setup Alfred"
echo "License key in 1Password"
open "$(ls -d /Applications/Alfred*)"
hitenter Alfred

echo "Setup iTerm"
echo "iCloud setting file is in iCloud Drive/Documents/AppSupport/iTerm"
echo "git saved version is in Repos/profile/configs/iTerm"
open "/Applications/iTerm.app"
hitenter iTerm

echo "Setup Sublime Text"
echo "Start App, input license from 1Pass, then setup saved config"
echo "Apparently my ST config is super fubar." 
open "/Applications/Sublime Text.app"
hitenter Sublime_Text

echo "Setup Amethyst"
open "/Applications/Amethyst.app"
hitenter Amethyst

echo "Setup Bash Profile"
curl -s https://raw.githubusercontent.com/sixty4k/profile/master/install | bash

