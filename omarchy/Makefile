SHELL := /bin/bash # Instruct make to use the bash shell.

-include Makefile-kanshi.mk
-include Makefile-uwsm.mk


.PHONY: install-applications
install-applications:
	bash install/mimetypes.sh
	bin/refresh-applications

install: install-applications install-uwsm-env install-kanshi
