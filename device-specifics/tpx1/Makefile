default:

$(HOME)/.config/wireplumber/wireplumber.conf.d/50-device-names.conf: config/wireplumber/wireplumber.conf.d/50-device-names.conf
	install -Dm644 "$(<)" "$@"
	systemctl --user restart wireplumber

wireplumber: $(HOME)/.config/wireplumber/wireplumber.conf.d/50-device-names.conf

/etc/udev/rules.d:
	sudo mkdir -p $@

/etc/udev/rules.d/99-disable-autosuspend-webcam.rules: etc/udev/rules.d/99-disable-autosuspend-webcam.rules
	sudo install -Dm644 "$<" "$@"
	sudo udevadm control --reload
	sudo udevadm trigger

/etc/udev/rules.d/99-disable-monitor-ethernet.rules: etc/udev/rules.d/99-disable-monitor-ethernet.rules
	sudo install -Dm644 "$<" "$@"
	@echo Reboot for the change to take effect.

udev: /etc/udev/rules.d/99-disable-monitor-ethernet.rules /etc/udev/rules.d/99-disable-autosuspend-webcam.rules
