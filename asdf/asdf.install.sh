ASDF_DIR=~/.asdf
ASDF_VERSION=v0.15.0

function install {
  if [ 0 != `dpkg -s $1 &> /dev/null ; echo $?` ] ; then
    sudo apt-get install -y $1
  fi
}

install sudo
install git
install curl

git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch $ASDF_VERSION

source $ASDF_DIR/asdf.sh

## Install node.js plugin

install dirmngr
install gpg
install curl
install gawk

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

asdf install

