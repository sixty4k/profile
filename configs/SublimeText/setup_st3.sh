#!/bin/bash

app_supp_sublime_folder=$(ls -d ~/Library/Application\ Support/Sublime\ * | grep Text)

rm -fr "${app_supp_sublime_folder}/Packages/User"

if [[ "$1" = "rsync" ]]; then
  rsync -avz User "${app_supp_sublime_folder}/Packages/"

else
  ln -s $(pwd)/User "${app_supp_sublime_folder}/Packages/User"

fi
