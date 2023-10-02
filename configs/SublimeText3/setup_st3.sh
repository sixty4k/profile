#!/bin/bash

rm -fr ~/Library/Application\ Support/Sublime\ Text/Packages/User

if [[ "$1" = "rsync" ]]; then
  rsync -avz User ~/Library/Application\ Support/Sublime\ Text/Packages/

else
  ln -s $(pwd)/User ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

fi
