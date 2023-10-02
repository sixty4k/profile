#!/bin/bash

hitenter() {
  echo "Hit Enter when $1 is setup"
  read
}



cd ~

mkdir Repos

rsync -avz /Users/mrobinson/Library/Mobile\ Documents/com~apple~CloudDocs/.ssh .
chmod 644 ~/.ssh/*

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
echo "License key in 1Password"`
open "$(ls -d /Applications/Alfred*)"
hitenter Alfred
 
