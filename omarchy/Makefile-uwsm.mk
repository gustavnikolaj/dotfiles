# Paths
UWSM_DEST      := $(HOME)/.config/uwsm/env
UWSM_DEST_DIR  := $(dir $(UWSM_DEST))
UWSM_BASE      := $(HOME)/.local/share/omarchy/config/uwsm/env
UWSM_EXTRA     := config/uwsm/env

.PHONY: install-uwsm-env
install-uwsm-env: $(UWSM_DEST)

# Ensure destination dir exists (order-only prerequisite)
$(UWSM_DEST_DIR):
	mkdir -p "$@"

# Build the destination file from BASE + EXTRA
# - Adds exactly one newline between the two
# - Only replaces the file if content actually changed
$(UWSM_DEST): $(UWSM_BASE) $(UWSM_EXTRA) | $(UWSM_DEST_DIR)
	@tmp="$$(mktemp)"; \
	cat "$(UWSM_BASE)" > "$$tmp"; \
	printf '\n' >> "$$tmp"; \
	sed 's|__FILE__|$(abspath $(UWSM_EXTRA))|g' "$(UWSM_EXTRA)" >> "$$tmp"; \
	install -Dm644 "$$tmp" "$@"; \
	rm -f "$$tmp"