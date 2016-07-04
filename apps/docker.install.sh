if [ 0 != `dpkg -s docker-engine &> /dev/null ; echo $?` ] ; then
  wget -qO- https://get.docker.com/ | sh

	echo Done: docker-engine

	echo 'Adding "'`whoami`'" to the docker group.'
	sudo usermod -aG docker `whoami`

	echo "You need to log out for docker to be available without being root."
fi
