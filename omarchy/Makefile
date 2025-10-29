SHELL := /bin/bash # Instruct make to use the bash shell.

-include Makefile-kanshi.mk
-include Makefile-uwsm.mk


.PHONY: install-applications
install-applications:		
	bash install/mimetypes.sh
	bash install/webapps.sh
	bin/refresh-applications

install: install-applications install-uwsm-env install-kanshi

/home/gno/.config/hypr/hyprland.conf: config/hypr/hyprland.conf
	install -Dm644 "$<" "$@"

.PHONY: hypr
hypr: /home/gno/.config/hypr/hyprland.conf