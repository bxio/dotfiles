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
else
  success
fi

# No help from next launch
touch ~/.hushlogin

# sleep 3 & doing "zzz"

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
for file in gitconfig gitignore hyper.js
do
  #rm ~/.$file &>/dev/null
  ln -s -i $DOTLOC/configs/$file $HOME/.$file
done
success

check "Installing completions..."
if [[ -x $FUNPATH/_repo ]]; then
  rm -f $FUNPATH/_repo
fi
ln -s "$DOTLOC/completions/_repo" $FUNPATH/_repo
success

# reload shell
exec hyper
