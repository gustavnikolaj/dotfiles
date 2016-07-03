#!/bin/bash
if [ 0 == `dpkg -s spotify-client &> /dev/null ; echo $?` ] ; then
  echo "Skipping: spotify (already installed)"
else
  echo "Installing: spotify"
  # Installing spotify client from testing repository instead of
  # stable, because of a dependency on libgcrypt.so.11 not shipped
  # with ubuntu 15.10
  # source: http://ubuntuhandbook.org/index.php/2015/09/install-spotify-client-ubuntu-15-10/
  echo deb http://repository.spotify.com testing non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
  sudo apt-get update
  sudo apt-get install spotify-client -y
  echo Done: spotify-client
fi
