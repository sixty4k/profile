#!/bin/bash

# Check for Homebrew (http://brew.sh)
# Install if we don't have it
if test ! $(which brew); then
  echo "> Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Make sure we can _run_ homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"

fi


# Update homebrew recipes
brew update

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# homebrew taps
echo "> Homebrew Tapping..."

brew bundle install --file=../homebrew/Brewfile.taps


#Brew Installs
echo "> Homebrew: Installing CLI stuffs..."

brew bundle install --file=../homebrew/Brewfile.brews

brew cleanup

#Brew Cask Installs
echo "> Homebrew: Installing Casks..."
brew bundle install --file=../homebrew/Brewfile.casks


#Brew Mac App Store Installs
echo "> Homebrew: Installing App Store Apps..."
brew bundle install --file=../homebrew/Brewfile.mass

brew cleanup

# echo "> Install all the gosh darn fonts possible"
# for i in $(brew search font | grep "font-"); do brew install ${i}; done
# # for i in $(brew search font | grep "nerd-font"); do brew install ${i}; done
# # for i in $(brew search font | grep "mono" | grep -v "nerd-font"); do brew install $i; done


