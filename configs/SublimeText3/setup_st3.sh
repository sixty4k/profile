#!/bin/bash

rm ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

if [[ "$1" = "rsync" ]]; then
  rsync -avz User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/

else

  ln -s $(pwd)/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
