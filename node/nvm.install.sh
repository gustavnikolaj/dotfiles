function install {
  if [ 0 != `dpkg -s $1 &> /dev/null ; echo $?` ] ; then
    sudo apt-get install -y $1
  fi
}

install build-essential
install libssl-dev
install git

NVM_DIR=$HOME/.nvm
PREVIOUS_WD=$(pwd)

if [ -f $NVM_DIR/nvm.sh ] ; then
  cd $NVM_DIR
  git pull
  cd $PREVIOUS_WD
else
  git clone https://github.com/creationix/nvm.git $NVM_DIR
fi
