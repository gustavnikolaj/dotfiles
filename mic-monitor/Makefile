SHELL := /bin/bash

# Symlink mic-monitor into ~/.local/bin. Symlinked rather than copied so edits
# in this repo take effect immediately, with no reinstall step.
# No sudo: this is a plain user-level script, nothing in /etc or /usr.

BINDIR := $(HOME)/.local/bin
TARGET := $(BINDIR)/mic-monitor

.PHONY: install
install:
	@mkdir -p $(BINDIR)
	ln -sfn $(CURDIR)/mic-monitor $(TARGET)
	@echo "Linked $(TARGET) -> $(CURDIR)/mic-monitor"
	@command -v mic-monitor >/dev/null 2>&1 \
		|| echo "WARNING: $(BINDIR) is not on your PATH"
	@echo "Toggle with: mic-monitor"

.PHONY: uninstall
uninstall:
	@if [[ -L $(TARGET) ]]; then \
		mic-monitor off 2>/dev/null || true; \
		rm -f $(TARGET); \
		echo "Removed $(TARGET)"; \
	else \
		echo "$(TARGET) is not a symlink, leaving it alone"; \
	fi

.PHONY: check
check:
	@./mic-monitor check
