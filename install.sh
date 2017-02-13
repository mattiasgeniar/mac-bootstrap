#!/bin/sh

source conf.d/install_functions

echo "Setting up your Mac..."

# Check for Homebrew and install if we don't have it
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update Homebrew recipes
brew update

# Install all our dependencies with bundle (See Brewfile)
brew tap homebrew/bundle
brew bundle --file=conf.d/Brewfile

# Make ZSH the default shell environment
chsh -s $(which zsh)

# If there's no zshrc file yet, copy the default
if [ ! -f ~/.zshrc ]; then
  wget https://raw.githubusercontent.com/mattiasgeniar/dotfiles/master/zsh/zshrc -O ~/.zshrc
fi

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Setup a ruby env
install_rbenv
install_rbenv_binstubs
git_config
