#!/usr/bin/env bash

# hr: create a line of dashes as wide as your terminal.
#
# adopted from: https://github.com/LuRsT/hr/blob/master/hr
hr() {
	local LINE=''
	while (( ${#LINE} < "$(tput cols)" ))
	do
	    LINE="$LINE-"
	done

	echo "${LINE}"
}

# shouldInstall: return boolean if a deb package is installed
shouldInstall () {
	if [ 0 == `dpkg -s $1 &> /dev/null ; echo $?` ] ; then
		echo "Skipping: $1 (already installed)"
		return 1
	else
		echo "Installing: $1"
		return 0
	fi
}

# prompt for sudo before starting

sudo echo Installing base setup.

hr

if shouldInstall google-chrome-stable ; then
	mkdir -p ~/Sources/
	wget \
		-nv \
		--show-progress \
		-O google-chrome-stable_current_amd64.deb \
		https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i ~/Sources/google-chrome-stable_current_amd64.deb
	echo Done: google-chrome-stable
fi

hr

# Installing spotify client from testing repository instead of
# stable, because of a dependency on libgcrypt.so.11 not shipped
# with ubuntu 15.10
# source: http://ubuntuhandbook.org/index.php/2015/09/install-spotify-client-ubuntu-15-10/
if shouldInstall spotify-client ; then
	echo deb http://repository.spotify.com testing non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys D2C19886
	sudo apt-get update
	sudo apt-get install spotify-client
	echo Done: spotify-client
fi

hr

# Installing docker for ubuntu
# Source: https://docs.docker.com/linux/step_one/
if shouldInstall docker-engine ; then
	wget -qO- https://get.docker.com/ | sh

	echo Done: docker-engine

	echo 'Adding "'`whoami`'" to the docker group.'
	sudo usermod -aG docker `whoami`

	echo "You need to log out for docker to be available without being root."
fi

hr

if shouldInstall atom ; then
	mkdir -p ~/Sources/
	wget https://atom.io/download/deb \
		-nv \
		--show-progress \
		-O ~/Sources/atom_stable.deb
	sudo dpkg -i ~/Sources/atom_stable.deb
	echo Done: atom
fi

hr

APT_PACKAGES="
	nautilus-dropbox
	keepass2
	pidgin
	pidgin-otr
	git
	vim
"

for p in $APT_PACKAGES ; do
	if shouldInstall $p ; then
		sudo apt-get install -y $p
	fi
	hr
done

ATOM_PACKAGES="
	linter
	linter-eslint
	language-cjson
	language-babel
	editorconfig
"

# install atom plugin if not already installed
for p in $ATOM_PACKAGES ; do
	if [ -d ~/.atom/packages/$p ] ; then
		echo "Skipping atom plugin: $p (already installed)"
	else
		apm install $p
	fi
	hr
done

echo Setup Dotfiles

hr

MAKE_TARGETS="
	bash
	git
	less
"

for t in $MAKE_TARGETS ; do
	echo Setting up: $t
	make $t
	hr
done

echo 'Creating Projects folder if it does not exist.'
mkdir -p ~/Projects

hr
