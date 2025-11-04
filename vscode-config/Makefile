CODE_CONFIG_DIR := $(HOME)/.config/Code/User
KEYBINDINGS_DST_FILE := $(CODE_CONFIG_DIR)/keybindings.json
SETTINGS_DST_FILE := $(CODE_CONFIG_DIR)/settings.json

.PHONY: install

default:
	@echo Run make -B install to configure the symlinks

install: $(SETTINGS_DST_FILE) $(KEYBINDINGS_DST_FILE)

$(CODE_CONFIG_DIR)/%.json: %.json
	ln -sf $(shell pwd)/$< $@
