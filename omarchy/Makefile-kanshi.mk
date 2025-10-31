USER_SYSTEMD_DIR := $(HOME)/.config/systemd/user
SRC_KANSHI_CONFIG  := config/kanshi/config
DST_KANSHI_CONFIG  := $(HOME)/.config/kanshi/config
SRC_KANSHI_UNIT  := config/systemd/user/kanshi.service
DST_KANSHI_UNIT  := $(USER_SYSTEMD_DIR)/kanshi.service

$(USER_SYSTEMD_DIR): 
	mkdir -p "$(USER_SYSTEMD_DIR)"

$(DST_KANSHI_UNIT): $(SRC_KANSHI_UNIT) | $(USER_SYSTEMD_DIR)
	install -Dm644 "$(SRC_KANSHI_UNIT)" "$(DST_KANSHI_UNIT)"
	systemctl --user daemon-reload
	systemctl --user enable --now kanshi.service

$(DST_KANSHI_CONFIG): $(SRC_KANSHI_CONFIG)
	install -Dm644 "$(SRC_KANSHI_CONFIG)" "$(DST_KANSHI_CONFIG)"
	systemctl --user restart kanshi.service

install-kanshi: $(DST_KANSHI_CONFIG) $(DST_KANSHI_UNIT)

uninstall-kanshi:
	systemctl --user disable --now kanshi.service || true
	rm =f "$(DST_KANSHI_CONFIG)"
	rm -f "$(DST_KANSHI_UNIT)"
	systemctl --user daemon-reload
