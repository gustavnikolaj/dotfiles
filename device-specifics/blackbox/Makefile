# blackbox - desktop driving the Dell monitor/KVM over USB-C.
# The monitor-ethernet rule is kept per-device; tpx1 has its own copy of it.

default:

$(HOME)/.config/wireplumber/wireplumber.conf.d/%.conf: config/wireplumber/wireplumber.conf.d/%.conf
	install -Dm644 "$(<)" "$@"

wireplumber: $(HOME)/.config/wireplumber/wireplumber.conf.d/50-device-names.conf
	systemctl --user restart wireplumber

/etc/udev/rules.d:
	sudo mkdir -p $@

/etc/udev/rules.d/99-disable-monitor-ethernet.rules: etc/udev/rules.d/99-disable-monitor-ethernet.rules
	sudo install -Dm644 "$<" "$@"
	sudo udevadm control --reload
	# rule matches ACTION=="add"; default trigger action is "change", so force add
	sudo udevadm trigger --action=add --subsystem-match=usb

udev: /etc/udev/rules.d/99-disable-monitor-ethernet.rules

.PHONY: default udev wireplumber
