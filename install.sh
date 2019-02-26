#!/bin/bash
tput civis

# Clear Line
CL="\e[2K"
# Spinner Character
SPINNER="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"

check () {
  printf "\\033[33m ➜ \\033[0m $1"
}

success () {
  printf "\\033[32m ✔ \\033[0m $1\\n"
}

fail () {
  printf "\\033[31m ✖ \\033[0m $1\\n"
  exit 1
}

function doing() {
  task=$1
  msg=$2
  while :; do
    jobs %1 > /dev/null 2>&1
    [ $? = 0 ] || {
      printf "${CL}\\033[32m ✔ \\033[0m ${task} Done\n"
      break
    }
    for (( i=0; i<${#SPINNER}; i++ )); do
      sleep 0.05
      printf "${CL} \\033[33m ➜ \\033[0m ${task} ${msg}... ${SPINNER:$i:1} \r"
    done
  done
}

tput cnorm

# define variables
DOTLOC=$HOME/.dotfiles
FUNPATH=/usr/local/share/zsh/site-functions

# exit if macos is not found
doing "Checking system..."
if [[ $(uname) != 'Darwin' ]]; then
  fail "You are not on a Mac :("
else
  success
fi

# exit if dotfiles exists
doing "Looking for dotfiles..."
if [[ -d  $DOTLOC ]]; then
  fail "\\033[2m$HOME/.dotfiles\\033[0m already exists."
  mv $HOME/.dotfiles $HOME/.dotfiles_old
else
  success
fi

# Remove bash last login
touch ~/.hushlogin

# create dotfiles directory and clone

[[ ! -d "$HOME/Projects" ]] && mkdir -p "$HOME/Projects" & git clone -q https://github.com/bxio/dotfiles.git "$DOTLOC" & doing "Cloning dotfiles"


# install homebrew if missing
if [[ ! -x "$(command -v brew)" ]]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" & doing "Installing homebrew"
else
  success "Homebrew is already installed.\\n"
fi


# install homebrew packages
brew bundle install --file="$DOTLOC/Brewfile" >/dev/null & doing "Installing packages"


# change default shell to zsh
chsh -s zsh & doing "Changing default shell to zsh"

# install spaceship prompt
check "Installing spaceship prompt..."
npm install -g spaceship-prompt
success


# link required files
check "Linking Files..."
# link zsh
for file in zshrc zshenv
do
  #rm ~/.$file &>/dev/null
  ln -s -i $DOTLOC/configs/zsh/$file $HOME/.$file
done

# link git, aliases, and hyper
for file in gitconfig gitignore gitignore_global hyper.js
do
  #rm ~/.$file &>/dev/null
  ln -s -i $DOTLOC/configs/$file $HOME/.$file & check "Linking $file..."
done
success

check "Installing completions..."
for file in repo hub
do
  if [[ -x $FUNPATH/_$file ]]; then
    rm -f $FUNPATH/_$file
  fi
  ln -s "$DOTLOC/completions/_$file" $FUNPATH/_$file & check "Linking $file..."
done
success

# Alfred
check "Loading Alfred Preferences..."
mkdir -p $HOME/Library/Application\ Support/Alfred\ 3/
ln -s -i $DOTLOC/mac/alfred $HOME/Library/Application\ Support/Alfred\ 3/Alfred.alfredpreferences
success

# Rocket
check "Loading Rocket Preferences..."
ln -s $DOTLOC/mac/Rocket $HOME/Library/Application\ Support/Rocket
# Docker for Mac
check "Loading Docker Preferences..."
ln -s $DOTLOC/mac/docker/settings.json $HOME/Library/Group\ Containers/group.com.docker/settings.json

### Langs stuff ###
# PHP
mkdir $HOME/.config/psysh
ln -s -i ${DOTLOC}/langs/php/psysh-config.php $HOME/.config/psysh/config.php
ln -s -i ${DOTLOC}/langs/php/composer.json $HOME/.composer/composer.json

# Clojure
mkdir $HOME/.config/clojure
ln -s -i ${DOTLOC}/langs/clojure/profiles.clj $HOME/.config/clojure/profiles.clj

# Scala
mkdir -p $HOME/.sbt/1.0/plugins
ln -s -i ${DOTLOC}/langs/scala/plugins.sbt $HOME/.sbt/1.0/plugins/plugins.sbt


# reload shell
exec hyper
