SHELL := /bin/bash # Instruct make to use the bash shell.

-include Makefile-kanshi.mk

.PHONY: install-applications
install-applications:
	bash install/mimetypes.sh
	bin/refresh-applications