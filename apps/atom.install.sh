#!/bin/bash

ATOM_PACKAGES="
linter
linter-eslint
linter-docker
language-docker
language-cjson
language-babel
editorconfig
"

# Make sure that curl is installed
if [ 0 != `dpkg -s curl &> /dev/null ; echo $?` ] ; then
  sudo apt-get install -y curl
fi

# Make sure that jq is installed
if [ 0 != `dpkg -s jq &> /dev/null ; echo $?` ] ; then
  sudo apt-get install -y jq
fi

function installAtom {
  local tmpdir="/tmp/atom-install-$(date +"%s")"
  mkdir -p $tmpdir
  curl -L -o $tmpdir/atom.deb https://atom.io/download/deb
  sudo dpkg -i $tmpdir/atom.deb
  rm -rf tmpdir
}

function checkAtom {
  if [ 0 == `dpkg -s atom &> /dev/null ; echo $?` ] ; then
    echo "atom: already installed, checking for updates"
    local latestVersion=`curl -s https://api.github.com/repos/atom/atom/releases/latest | jq -r .name`
    local installedVersion=`dpkg -s atom | grep Version | sed 's/Version: //'`
    if [ "$latestVersion" == "$installedVersion" ] ; then
      echo "atom: up to date"
    else
      echo "atom: new version released, updating."
      installAtom
    fi
  else
    echo "atom: installing"1
    installAtom
  fi
}

function installPlugins {
  # install atom plugin if not already installed
  for p in $ATOM_PACKAGES ; do
  	if [ ! -d ~/.atom/packages/$p ] ; then
  		apm install $p
  	fi
  done
}

checkAtom
installPlugins
apm upgrade
