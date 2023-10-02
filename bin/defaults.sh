#!/bin/sh
# Sets reasonable macOS defaults.
#
# inspired by https://github.com/caarlos0/dotfiles/blob/master/macos/set-defaults.sh
# jacked from https://github.com/mattstratton/matty-dotfiles/blob/master/setup/osx.sh


if [ "$(uname -s)" != "Darwin" ]; then
	exit 0
fi

set +e

echo "> Various OS X Tunings"

echo "> Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "

echo "> Show the ~/Library folder"
chflags nohidden ~/Library

echo "> Don't automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

echo "> Avoid the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "> Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "> Set graphite appearance"
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

echo "> Set graphite highlight color"
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745"

echo "> Disable machine sleep while charging"
sudo pmset -c sleep 0

echo "> Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

echo "> Disable smart quotes"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "> Disable smart dashes"
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "> Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

echo "> software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "> Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

#############################

echo "# Screenshots"
echo "> Screenshots Location"
# Directory must exist!
mkdir -p ~/Documents/screenshots
defaults write com.apple.screencapture location -string "${HOME}/Documents/screenshots"
killall SystemUIServer

echo "> Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

echo "> No Shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

echo "> Disable opening photos or other program on attaching a 'camera'"
defaults write com.apple.ImageCapture disableHotPlug -bool YES

#############################

echo ""
echo "› Finder:"
echo "> Always open everything in Finder's list view"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

echo "> NO WIRE HANGERS, err, no icons on the desktop"
# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

echo "> Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "> Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "> Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "> Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "> show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true

echo "> show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo "> search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

echo "> Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

echo "> Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "> Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "> Nothing on the desktop!"
defaults write com.apple.finder CreateDesktop -bool false

#############################

echo ""
echo "› Time Machine:"
echo "> Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

#############################

echo ""
echo "› Dock:"
echo "> Wipe all (default) app icons from the Dock"
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

echo "> Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "> Only show active apps in Dock"
defaults write com.apple.dock static-only -bool true

echo "> Make the dock small af; 16 is the lowest the UI control goes"
defaults write com.apple.dock tilesize -integer 12

#############################

echo ""
echo "› Mail.app"

echo "> Disable send and reply animations in Mail.app"
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

echo '> Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app'
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

echo "> Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" -string "@\\U21a9"

echo "> Display emails in threaded mode, sorted by date (oldest at the top)"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

echo "> Disable inline attachments (just show the icons)"
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true


#############################

echo ""
echo "› Safari"

echo '> Show full URL, always.  Why have we forsaken ourselves?'
defaults write com.apple.Safari "ShowFullURLInSmartSearchField" -bool "true" 

#############################

echo ""
echo "› Kill related apps"
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
	"Dock" "Finder" "Mail" "Messages" "SystemUIServer" ; do
	killall "$app" >/dev/null 2>&1
done
set -e
