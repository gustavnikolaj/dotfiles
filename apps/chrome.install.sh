#!/bin/bash

function main {
  if [ 0 == `dpkg -s google-chrome-stable &> /dev/null ; echo $?` ] ; then
    echo "Skipping: google-chrome (already installed)"
  else
    tmpdir="/tmp/chrome-install-$(date +"%s")"
    mkdir -p $tmpdir
    curl -L -o $tmpdir/chrome.deb \
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i $tmpdir/chrome.deb
    rm -rf $tmpdir
    echo Done: google-chrome
  fi
}

main
