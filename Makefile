.PHONY: default
default:
	@echo "makescript for dotfiles"

.PHONY: setup
setup:
	mkdir -p ~/.local/bin
	mkdir -p ~/.local/share
	mkdir -p ~/.local/lib
	mkdir -p ~/.config

.PHONY: bash
bash: setup inputrc
	rm -f ${HOME}/.bashrc ${HOME}/.config/bash.d
	ln -s ${PWD}/bashrc.sh ${HOME}/.bashrc
	ln -t ${HOME}/.config -s ${PWD}/bash.d

.PHONY: inputrc
inputrc:
	rm -f ${HOME}/.inputrc
	ln -s ${PWD}/inputrc.sh ${HOME}/.inputrc

.PHONY: xmodmap
xmodmap:
	rm -f ${HOME}/.Xmodmap
	ln -s ${PWD}/Xmodmap ${HOME}/.Xmodmap

evil-config:
	git clone git@github.com:gustavnikolaj/evil-config.git
	echo "export DOTFILESPATH=${PWD}" >> ${HOME}/.bash_local
	rm -f ${HOME}/.emacs
	ln -s ${PWD}/evil-config/emacs.el ${HOME}/.emacs

.PHONY: evil-config-clean
evil-config-clean:
	rm -rf evil-config

.PHONY: evil-config-update
evil-config-update:
	cd evil-config && git pull --rebase origin master

.PHONY: git
git:
	rm -rf ${HOME}/.gitconfig
	rm -rf ${HOME}/.gitattributes
	ln -s ${PWD}/gitconfig ${HOME}/.gitconfig
	ln -s ${PWD}/gitattriibutes ${HOME}/.gitattriibutes

.PHONY: dunst
dunst: setup
	mkdir -p ${HOME}/.config/dunst
	rm -rf ${HOME}/.config/dunst/dunstrc
	ln -s ${PWD}/dunstc ${HOME}/.config/dunst/dunstrc

.PHONY: xsession
xsession: setup
	rm -rf ${HOME}/.xsession
	ln -s ${PWD}/xsession ${HOME}/.xsession

.PHONY: i3
i3: setup xsession dunst xmodmap i3-xsession
	mkdir -p ${HOME}/.i3
	rm -rf ${HOME}/.i3/config
	rm -rf ${HOME}/.i3/scripts
	rm -rf ${HOME}/.i3/status
	ln -s ${PWD}/i3/config ${HOME}/.i3/config
	ln -s ${PWD}/i3/scripts ${HOME}/.i3/scripts
	ln -s ${PWD}/i3/status ${HOME}/.i3/status

.PHONY: vim
vim:
	@# remove previously installed bundles
	rm -rf ~/.vim/bundle
	@echo ""
	@echo ""
	@# create folder for bundles
	mkdir -p ~/.vim/bundle
	@echo ""
	@echo ""
	@# clone vundle
	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@echo ""
	@echo ""
	@# stow vim files
	stow vim
	@echo ""
	@echo ""
	@# launch vim, bundleinstall and quit
	vim -c BundleInstall -c q -c q
	@echo ""
	@echo ""
	@echo "Done!"

.PHONY: i3-xsession
i3-xsession:
	sudo rm -f /usr/share/xsessions/i3.desktop
	sudo cp i3/i3.desktop /usr/share/xsessions/i3.desktop

.PHONY: i3-disable-desktop
i3-disable-desktop:
	gsettings set org.gnome.desktop.background show-desktop-icons false

.PHONY: i3-enable-desktop
i3-enable-desktop:
	gsettings set org.gnome.desktop.background show-desktop-icons true

z: setup
	git clone git@github.com:rupa/z.git
	rm -f ~/.local/lib/z
	ln -t ~/.local/lib -s ${PWD}/modules/z
