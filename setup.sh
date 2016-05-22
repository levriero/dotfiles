#!/bin/bash

set -e

echo " > Pulling latest changes..."
git pull &> /dev/null

brew bundle check

if ! [ $? -eq 0 ]; then
  echo "\n > Installing dependencies..."
  brew tap Homebrew/bundle
  brew bundle
fi

if ! hash bundle 2>/dev/null; then
  echo "\n > Installing bundler..."
  gem install bundler
fi

echo "\n > Creating symlinks..."

for file in $(ls -A); do
  if [[ $file =~ ^\. ]]; then
    if [ -f $HOME/$file ] || [ -d $HOME/$file ]; then
      echo "  >> $file already exists"
    elif [ $file == '.git' ]; then
      continue
    else
      echo "  >> Symlinking $file"
      ls -s $file $HOME/$file
    fi
  fi
done

echo "\n > Done!"
