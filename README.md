## Introduction

This is the development environment set up for my MacBook. It contains configuration files (dotfiles) and scripts that will automatically restore my apps, IDE extensions and settings, GitHub credentials and system preferences whenever I need to set up a new MacBook.

If you find this useful, feel free to fork this repository and make it your own!

## Setting up a new MacBook

1. Connect to the internet
1. Update macOS to the latest version
1. Log in to iCloud and enable iCloud Keychain
1. Log in to the App Store
1. Log in to [GitHub](https://github.com) and ensure that the password is saved in iCloud Keychain
1. Clone this repository into the `~/.dotfiles` local directory using `git clone https://github.com/tigeryst/dotfiles ~/.dotfiles`
1. Run the bootstrap installation with `~/.dotfiles/bootstrap.sh`
1. Restart the computer to ensure changes are applied

## Before restoring to factory settings

1. Make sure that the dotfiles are up to date with the current set up
1. Commit and push any changes to local repositories to GitHub
1. Make a Time Machine backup
1. Make sure all important files are uploaded to the cloud (Google Drive, iCloud, etc.)

## The set up sequence

These steps are automated with the [`bootstrap.sh`](bootstrap.sh) script.

1. Install Xcode, Oh My Zsh and Homebrew.
2. Install apps
3. Install Visual Studio Code (VS Code) extensions
4. Set up GitHub credentials
5. Clone active Git repositories
6. Install iTerm2 plugins
7. Symbolic link Z Shell (Zsh), VS Code and Haskell interpreter configuration files
8. Restore macOS settings
9. Prompt to log in and sync with Google Drive

## Tweaking the set up

The set up steps are spread across various files and can be tweaked as needed. Keeping the dotfiles up the date also requires constant maintenance and a little different approach to installing apps and editing settings.

### Apps

Apps should be managed through the Homebrew package manager.

- To remove an app, run `brew uninstall app_name` then make sure to remove the app from the [`brew/Brewfile`](brew/Brewfile)
- To install a new app, check if the app to install is available from the [Homebrew directory](https://caskroom.github.io/search) and run 'brew install app_name' then make sure to add the app to the brew/Brewfile
- If the app is not available on Homebrew but is instead available on the App Store, install it from the App Store and add it to the Brewfile under the [mas](https://github.com/mas-cli/mas) section

The [`brew/install.sh`](brew/install.sh) script executes the Bew installations and starts background services such as MySQL or MongoDB databases.

### VS Code

Installation commands for the VS Code extensions is listed in the [`vscode/extensions.sh`](vscode/extensions.sh) script.

- When installing a new extension, make sure to append `code --install-extension extension_id` to the script. Extension ID can be copied from the extensions tab on VS Code.
- When uninstalling an extension, make sure to remove the corresponding command from the script.

User settings for VS Code are symlinked to the [`vscode/settings.json`](vscode/settings.json) file so any settings changed from VS Code is automatically reflected in the file which is committed to this repo.

### macOS settings

On a Mac, system settings are normally stored in Property List files (PLIST) in an XML key-value pair format. These settings can be read using `defaults read domain_name key` and overwritten with `defaults write domain_name key value`. Do an internet search to find the right command for the setting you are looking for.

The [`os/macos.sh`](os/macos.sh) script contains such settings commands including region format, languages, menu bar, dock, keyboard and trackpad. Instead of updating settings through the System Settings UI, try to find the right command and add it to the script.

### Oh My Zsh

To configure how the Zsh looks and behaves, the theme, plugins and other settings can be configured in [`terminal/.zshrc`](terminal/.zshrc). Custom plugins are installed in [`terminal/install.sh`](terminal/install.sh).

To add shorthand for commands or aliases, check out [`terminal/aliases.zsh`](terminal/aliases.zsh). The `$PATH` variable is set in [`terminal/path.zsh`](terminal/path.zsh). These files get loaded in because the `$ZSH_CUSTOM` setting points to the [`terminal`](terminal) directory.

More info about how to customize Oh My Zsh can be found [here](https://github.com/robbyrussell/oh-my-zsh/wiki/Customization).

## Acknowledgements

I would like to thank [Sourabh Bajaj](https://sourabhbajaj.com/mac-setup/) for my current development set up, [Dries Vints](https://driesvints.com/blog/getting-started-with-dotfiles) for the comprehensive starter code for my dotfiles allowing me to automate everything, [Emmanuel Maggion](https://gist.github.com/kamui545/c810eccf6281b33a53e094484247f5e8) for the command line Dock set up and [Mathias Bynens](https://mths.be/macos) for the original script to modify the macOS defaults.
