SHELL := /bin/bash

# Auto-apply zoom_absolute=150 to a Logitech C920 on (re)connect, via udev +
# systemd. Touches /etc and /usr/local/bin, hence sudo.

.PHONY: install
install:
	sudo install -Dm755 set-c920-zoom /usr/local/bin/set-c920-zoom
	sudo install -Dm644 99-c920-zoom.rules /etc/udev/rules.d/99-c920-zoom.rules
	sudo install -Dm644 set-c920-zoom.service /etc/systemd/system/set-c920-zoom.service
	sudo systemctl daemon-reload
	sudo udevadm control --reload-rules
	@echo "Installed. Replug the webcam, or trigger now with:"
	@echo "  sudo udevadm trigger --action=add --subsystem-match=video4linux"

.PHONY: uninstall
uninstall:
	sudo rm -f /usr/local/bin/set-c920-zoom
	sudo rm -f /etc/udev/rules.d/99-c920-zoom.rules
	sudo rm -f /etc/systemd/system/set-c920-zoom.service
	sudo systemctl daemon-reload
	sudo udevadm control --reload-rules
	@echo "Uninstalled."
