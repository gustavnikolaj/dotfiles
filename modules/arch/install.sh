#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

set -eo pipefail

catch_errors() {
  echo -e "\n\e[31mInstallation failed!\e[0m"
  echo "You can retry by running the script again"
}

trap catch_errors ERR

for f in install/*.sh; do
  echo -e "\nRunning installer: $f"
  source "$f"
done

# Config
source install/config/login.sh
source install/config/plymouth.sh

# Ensure locate is up to date now that everything has been installed
sudo updatedb

# Update all built-in packages
sudo pacman -Syu --noconfirm

echo "Done. If something is not working, try a reboot."
