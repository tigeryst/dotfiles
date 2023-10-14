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
  app_string="
  <dict>
    <key>tile-data</key>
    <dict>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>${app}.app</string>
        <key>_CFURLStringType</key>
        <integer>0</integer>
      </dict>
    </dict>
  </dict>
  "
  defaults write com.apple.dock persistent-apps -array-add "$app_string"
done

defaults write com.apple.dock persistent-others -array

for other in \
  "${HOME}/Downloads/"; do
  other_string="
  <dict>
    <key>tile-data</key>
    <dict>
      <key>displayas</key>
      <integer>0</integer>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>file://${other}</string>
        <key>_CFURLStringType</key>
        <integer>15</integer>
      </dict>
      <key>file-type</key>
      <integer>2</integer>
      <key>showas</key>
      <integer>0</integer>
    </dict>
    <key>tile-type</key>
    <string>directory-tile</string>
  </dict>
  "
  defaults write com.apple.dock persistent-others -array-add "$other_string"
done

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
