#!/bin/bash

#MAS Installs
echo "Go to the App Store and install XCode"

read -p "Continue [y/n]" carryon
case $carryon in
    [Yy]* ) echo "Carrying On";;
    [Nn]* ) exit;;
    * ) echo "Please answer yes or no." ; exit;;
esac


# Check for Homebrew (http://brew.sh)
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# homebrew taps
echo "Homebrew Tapping..."

taps=(
    homebrew/cask
    homebrew/cask-fonts
    homebrew/cask-versions
)

for i in ${taps[@]}; do
    brew tap $i
done

#Brew Installs
echo "Installing CLI stuffs..."

brews=(
    remind101/formulae/assume-role
    amazon-ecs-cli
    awscli
    brew-cask-completion
    bash-completion
    curl
    moul/moul/docker-diff
    fzf
    git
    googler
    hugo
    ipcalc
    TomAnthony/brews/itermocil
    jq
    lame
    links
    mackup
    mtr
    nmap
    node
    nvm
    ntopng
    openssl
    packer
    pre-commit
    pwgen
    python
    python@2
    rbenv
    ruby-build
    stoken
    telnet
    terminal-notifier
    tree
    tfenv
    tflint
    tldr
    unrar
    vault
    vagrant-completion
    watch
    wget
    youtube-dl
)

# brew install ${brews[@]}
for cli_app in ${brews[@]}; do
    # For loop instead of passing everything to brew means
    # any failures only effect that package not the whole list
    if brew install ${cli_app}; then
        echo "${cli_app} done"
    else
        echo "${cli_app}" >> ~/homebrew_problem_installs
    fi
done

brew cleanup

#Brew Cask Installs
echo "Installing Casks"
casks=(
    alfred
    amethyst
    choosy
    cloudytabs
    dropbox
    firefox
    fluid
    fromscratch
    hammerspoon
    iterm2
    launchrocket
    nvalt
    sublime-text
    sublime-merge
    vagrant
    virtualbox
)

fonts=(
    font-source-code-pro
    font-hack
)

for cask_app in ${casks[@]} ${fonts[@]}; do
    if brew cask install ${cask_app}; then
        echo "${cask_app} done"
    else
        echo "${cask_app}" >> ~/homebrew_problem_installs
    fi
done

Echo "Various OS X Tunings"

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`


# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false


# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Screenshots location
# Directory must exist!
mkdir -p ~/Dropbox/screenshots
defaults write com.apple.screencapture location -string "${HOME}/Dropbox/screenshots"
killall SystemUIServer

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true


# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable send and reply animations in Mail.app
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

# Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable opening photos or other program on attaching a 'camera'
defaults write com.apple.ImageCapture disableHotPlug -bool YES

echo "Setting up Bash Profile"

curl -s https://raw.githubusercontent.com/sixty4k/profile/master/install | bash
