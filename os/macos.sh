#!/usr/bin/env bash

echo "Restoring system preferences..."

# Check if script is running as the main script and not being sourced
if [ "$0" = "$BASH_SOURCE" ]; then
  # Ask for the administrator password upfront
  sudo -v

  # Keep-alive: update existing sudo timestamp until script has finished
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done 2>/dev/null &
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "Tiger's MacBook Pro"
sudo scutil --set HostName "Tiger's MacBook Pro"
sudo scutil --set LocalHostName "Tigers-MacBook-Pro"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "Tiger's MacBook Pro"

# Set apps in dock
defaults write com.apple.dock persistent-apps -array

for app in \
  "/System/Applications/Launchpad" \
  "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari" \
  "/System/Applications/Messages" \
  "/System/Applications/Mail" \
  "/Applications/LINE" \
  "/Applications/WhatsApp" \
  "/Applications/WeChat" \
  "/Applications/Telegram" \
  "/Applications/Messenger" \
  "/System/Applications/FaceTime" \
  "/System/Applications/System Settings" \
  "/Applications/Spotify" \
  "/Applications/GoodNotes" \
  "/Applications/Google Chrome" \
  "/Applications/iTerm" \
  "/Applications/Visual Studio Code" \
  "/Applications/Postman" \
  "/System/Applications/App Store"; do
  app_string="<dict><key>tile-data</key><dict><key>file-data</key><dict>"
  app_string+="<key>_CFURLString</key><string>${app}.app</string>"
  app_string+="<key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"
  defaults write com.apple.dock persistent-apps -array-add "$app_string"
done

defaults write com.apple.dock persistent-others -array

for other in \
  "/Users/tiger/Downloads/"; do
  other_string="<dict><key>tile-data</key><dict><key>file-data</key><dict>"
  other_string+="<key>_CFURLString</key><string>file://${other}</string>"
  other_string+="<key>_CFURLStringType</key><integer>15</integer></dict></dict>"
  other_string+="<key>tile-type</key><string>directory-tile</string></dict>"
  defaults write com.apple.dock persistent-others -array-add "$other_string"
done

# TODO: set up preferences

# # Expand save panel by default
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# # Expand print panel by default
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# # Save to disk (not to iCloud) by default
# defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# # Reveal IP address, hostname, OS version, etc. when clicking the clock
# # in the login window
# sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# # Disable automatic capitalization as it’s annoying when typing code
# defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# # Disable automatic period substitution as it’s annoying when typing code
# defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# # Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# ###############################################################################
# # Menu bar                                                                    #
# ###############################################################################
# # Show seconds in menu bar digital clock
# defaults write com.apple.menuextra.clock DateFormat -string "EEE d MMM HH:mm:ss"
# defaults write com.apple.menuextra.clock Show24Hour -int 1
# defaults write com.apple.menuextra.clock ShowSeconds -int 1

# # Show Time Machine in menu bar
# defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"

# # Show Bluetooth in menu bar
# defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

# ###############################################################################
# # Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
# ###############################################################################

# # Trackpad: enable tap to click for this user and for the login screen
# defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# # Trackpad: enable three-finger drag
# defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true

# # Trackpad: tracking speed
# defaults write -g com.apple.mouse.scaling 3.0

# # Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# # Set language and text formats
# # Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# # `Inches`, `en_GB` with `en_US`, and `true` with `false`.
# defaults write NSGlobalDomain AppleLanguages -array "en-GB" "th-TH"
# defaults write NSGlobalDomain AppleLocale -string "en_TH"
# defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
# defaults write NSGlobalDomain AppleMetricUnits -bool true

# ###############################################################################
# # Energy saving                                                               #
# ###############################################################################

# # Enable lid wakeup
# sudo pmset -a lidwake 1

# # Restart automatically on power loss
# sudo pmset -a autorestart 1

# # Restart automatically if the computer freezes
# # sudo systemsetup -setrestartfreeze on

# ###############################################################################
# # Screen                                                                      #
# ###############################################################################

# # Require password immediately after sleep or screen saver begins
# defaults write com.apple.screensaver askForPassword -int 1
# defaults write com.apple.screensaver askForPasswordDelay -int 0

# # Save screenshots to the downloads folder
# defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# defaults write com.apple.screencapture type -string "png"

# # Disable shadow in screenshots
# defaults write com.apple.screencapture disable-shadow -bool true

# ###############################################################################
# # Finder                                                                      #
# ###############################################################################

# # Finder: show all filename extensions
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# # Finder: show status bar
# defaults write com.apple.finder ShowStatusBar -bool true

# # Finder: show path bar
# defaults write com.apple.finder ShowPathbar -bool true

# # Remove toolbar title hovering delay
# defaults write NSGlobalDomain "NSToolbarTitleViewRolloverDelay" -float "0"

# # Keep folders on top when sorting by name
# defaults write com.apple.finder _FXSortFoldersFirst -bool true

# # When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# # Disable the warning when changing a file extension
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# # Enable spring loading for directories
# defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# # Remove the spring loading delay for directories
# defaults write NSGlobalDomain com.apple.springing.delay -float 0

# # Avoid creating .DS_Store files on network or USB volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# # Use list view in all Finder windows by default
# # Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
# defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# ###############################################################################
# # Dock, Dashboard, and hot corners                                            #
# ###############################################################################

# # Minimize windows into their application’s icon
# defaults write com.apple.dock minimize-to-application -bool true

# # Don’t animate opening applications from the Dock
# defaults write com.apple.dock launchanim -bool false

# # Speed up Mission Control animations
# defaults write com.apple.dock expose-animation-duration -float 0.1

# # Don’t automatically rearrange Spaces based on most recent use
# defaults write com.apple.dock mru-spaces -bool false

# # Remove the auto-hiding Dock delay
# defaults write com.apple.dock autohide-delay -float 0
# # Remove the animation when hiding/showing the Dock
# defaults write com.apple.dock autohide-time-modifier -float 0

# # Automatically hide and show the Dock
# defaults write com.apple.dock autohide -bool true

# # Don’t show recent applications in Dock
# defaults write com.apple.dock show-recents -bool false

# # Reset Launchpad, but keep the desktop wallpaper intact
# defaults write com.apple.dock ResetLaunchPad -bool true

# ###############################################################################
# # Safari & WebKit                                                             #
# ###############################################################################

# # Show the full URL in the address bar (note: this still hides the scheme)
# defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# # Enable the Develop menu and the Web Inspector in Safari
# defaults write com.apple.Safari IncludeDevelopMenu -bool true
# defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# # Update extensions automatically
# defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

# ###############################################################################
# # Terminal & iTerm 2                                                          #
# ###############################################################################

# # Don’t display the annoying prompt when quitting iTerm
# defaults write com.googlecode.iterm2 PromptOnQuit -bool false

# ###############################################################################
# # Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
# ###############################################################################

# # Use plain text mode for new TextEdit documents
# defaults write com.apple.TextEdit RichText -int 0

# ###############################################################################
# # Mac App Store                                                               #
# ###############################################################################

# # Enable the automatic update check
# defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# # Check for software updates daily, not just once per week
# defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# # Download newly available updates in background
# defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# # Install System data files & security updates
# defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# # Turn on app auto-update
# defaults write com.apple.commerce AutoUpdate -bool true

# # Allow the App Store to reboot machine on macOS updates
# defaults write com.apple.commerce AutoUpdateRestartRequired -bool true

# ###############################################################################
# # Google Chrome & Google Chrome Canary                                        #
# ###############################################################################

# # Disable the all too sensitive backswipe on trackpads
# defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
# # defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# # Disable the all too sensitive backswipe on Magic Mouse
# defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
# # defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# # Use the system-native print preview dialog
# defaults write com.google.Chrome DisablePrintPreview -bool true
# # defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# # Expand the print dialog by default
# defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
# # defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

# Kill affected applications
for app in \
  "Address Book" \
  "Calendar" \
  "Contacts" \
  "Dock" \
  "Finder" \
  "Google Chrome" \
  "Mail" \
  "Messages" \
  "Safari" \
  "SytemUIServer"; do
  killall "${app}" &>/dev/null
done
