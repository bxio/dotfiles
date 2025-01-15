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


DOTLOC=$HOME/.dotfiles
FUNPATH=/usr/local/share/zsh/site-functions

# link git, aliases, and hyper
for file in gitignore_global
do
  #rm ~/.$file &>/dev/null
  ln -s -i $DOTLOC/configs/$file $HOME/.$file & check "Linking $file..."
done
success
