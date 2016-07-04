if [ 0 != `dpkg -s vim &> /dev/null ; echo $?` ] ; then
  sudo apt-get install -y vim
fi

mkdir -p ~/.vim/bundle

vundledir=~/.vim/bundle/vundle

if [ -d "$vundledir/.git" ]; then
  pushd $vundledir
  git pull
  popd
else
  rm -rf $vundledir
  git clone https://github.com/gmarik/vundle.git $vundledir
fi
