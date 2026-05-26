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
install unzip

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin-add helm https://github.com/Antiarchitect/asdf-helm.git
asdf plugin-add golang https://github.com/asdf-community/asdf-golang
asdf plugin-add yq https://github.com/sudermanjr/asdf-yq.git
asdf plugin-add jq https://github.com/lsanwick/asdf-jq.git
asdf plugin-add kubectl https://github.com/asdf-community/asdf-kubectl.git
asdf plugin add awscli https://github.com/MetricMike/asdf-awscli.git

asdf install

