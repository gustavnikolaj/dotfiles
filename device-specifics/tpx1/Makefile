default:

SRC_DEVICE_NAMES := config/wireplumber/wireplumber.conf.d/50-device-names.conf
DST_DEVICE_NAMES := $(HOME)/.config/wireplumber/wireplumber.conf.d/50-device-names.conf

$(DST_DEVICE_NAMES): $(SRC_DEVICE_NAMES)
	install -Dm644 "$(SRC_DEVICE_NAMES)" "$(DST_DEVICE_NAMES)"
	systemctl --user restart wireplumber

install: $(DST_DEVICE_NAMES)

/etc/udev/rules.d:
	sudo mkdir -p $@

/etc/udev/rules.d/99-disable-autosuspend-webcam.rules: etc/udev/rules.d/99-disable-autosuspend-webcam.rules
	sudo install -Dm644 "$<" "$@"
	sudo udevadm control --reload
	sudo udevadm trigger

/etc/udev/rules.d/99-disable-monitor-ethernet.rules: etc/udev/rules.d/99-disable-monitor-ethernet.rules
	sudo install -Dm644 "$<" "$@"
	@echo Reboot for the change to take effect.
