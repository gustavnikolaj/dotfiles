HUB_INSTALL_PATH=~/.local/bin

# Make sure that curl is installed
if [ 0 != `dpkg -s curl &> /dev/null ; echo $?` ] ; then
  sudo apt-get install -y curl
fi

function downloadLatestHub {
  local latestReleaseUrl=$( \
    curl -s https://api.github.com/repos/github/hub/releases/latest \
    | jq -r '.assets[] | select(.label|endswith("Linux 64-bit")) | .browser_download_url' \
  )
  local tmpdir="/tmp/hub-install-$(date +"%s")"
  mkdir -p $tmpdir
  mkdir -p $HUB_INSTALL_PATH
  curl -L -o $tmpdir/hub.tgz $latestReleaseUrl
  pushd $tmpdir
  tar xf $tmpdir/hub.tgz
  local hubBin=$(find $tmpdir -type f -name hub)
  cp $hubBin $HUB_INSTALL_PATH/git
  popd
  rm -rf $tmpdir
}

function installedHubVersionUpToDate {
  local installedVersion=$(git --version | grep hub | sed 's/^hub version //')
  local remoteVersion=$( \
    curl -s https://api.github.com/repos/github/hub/releases/latest \
    | jq -r '.assets[] | select(.label|endswith("Linux 64-bit")) | .label' \
    | sed 's/^hub //' \
    | sed 's/ for Linux 64-bit$//'
  )

  if [ "$installedVersion" == "$remoteVersion" ] ; then
    return 0
  else
    return 1
  fi
}

function main {
  if installedHubVersionUpToDate ; then
    echo "hub: up to date"
  else
    echo "hub: installing"
    downloadLatestHub
  fi
}

main
