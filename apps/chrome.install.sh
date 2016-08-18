#!/bin/bash

function main {
    if [ 0 == `dpkg -s google-chrome-stable &> /dev/null ; echo $?` ] ; then
      echo "Skipping: google-chrome (already installed)"
    else
      echo "Installing: google-chrome"
      echo "deb [arch=amd64] https://dl-ssl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list
      wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
      sudo apt-get update
      sudo apt-get install google-chrome-stable -y
      echo Done: google-chrome
    fi
}

main
