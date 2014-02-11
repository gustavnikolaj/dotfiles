.PHONY: default
default:
	@echo "makescript for dotfiles"

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
	sudo cp i3/.i3/i3.desktop /usr/share/xsessions/i3.desktop
