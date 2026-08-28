# Symlinks everything in config/<app>/ into ~/.config/<app>/.
# To manage a new file: copy it into config/<app>/, then run `make install`.

SRC := $(wildcard config/*/*)
DST := $(patsubst config/%,$(HOME)/.config/%,$(SRC))

.PHONY: default install status

default: status
	@echo
	@echo "Run 'make install' to (re)create the symlinks."

install: $(DST)

$(HOME)/.config/%: config/%
	@mkdir -p $(dir $@)
	ln -sfn $(CURDIR)/$< $@

status:
	@echo "Managed here:"
	@if [ -z "$(SRC)" ]; then echo "  (nothing yet)"; \
	else for f in $(SRC); do \
	  r="$${f#config/}"; d="$(HOME)/.config/$$r"; \
	  if [ -L "$$d" ]; then echo "  linked   $$r"; \
	  elif [ -e "$$d" ]; then echo "  NOT LINK $$r  (real file in ~/.config)"; \
	  else echo "  missing  $$r"; fi; \
	done; fi
