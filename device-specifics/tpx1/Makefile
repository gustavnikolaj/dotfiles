default:

SRC_DEVICE_NAMES := config/wireplumber/wireplumber.conf.d/50-device-names.conf
DST_DEVICE_NAMES := $(HOME)/.config/wireplumber/wireplumber.conf.d/50-device-names.conf

$(DST_DEVICE_NAMES): $(SRC_DEVICE_NAMES)
	install -Dm644 "$(SRC_DEVICE_NAMES)" "$(DST_DEVICE_NAMES)"
	systemctl --user restart wireplumber

install: $(DST_DEVICE_NAMES)