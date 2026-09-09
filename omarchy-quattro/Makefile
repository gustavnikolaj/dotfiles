# Symlinks every file under config/ into the matching path in ~/.config/.
# To manage a new file: copy it into config/<app>/, then run `make install`.
#
# Nested paths work: config/uwsm/env.d/50-dotfiles links to
# ~/.config/uwsm/env.d/50-dotfiles.

SRC := $(shell find config -type f ! -name .gitkeep 2>/dev/null | sort)

.PHONY: default install status

default: status
	@echo
	@echo "Run 'make install' to (re)create the symlinks."

# Phony, rather than one file target per link. A symlink is not a build product,
# so make's mtime test asks the wrong question: it skipped any destination that
# already existed and happened to be newer than the source, which is every first
# install over a stock Omarchy config. `ln -sfn` is idempotent, so just always
# run it.
#
# Caveat: `ln -sfn` onto an existing real directory links *inside* it rather than
# replacing it. Only matters if a whole directory is ever managed here.
install:
	@for f in $(SRC); do \
	  d="$(HOME)/.config/$${f#config/}"; \
	  mkdir -p "$$(dirname "$$d")"; \
	  ln -sfn "$(CURDIR)/$$f" "$$d" && echo "  linked   $${f#config/}"; \
	done

status:
	@echo "Managed here:"
	@if [ -z "$(SRC)" ]; then echo "  (nothing yet)"; \
	else for f in $(SRC); do \
	  r="$${f#config/}"; d="$(HOME)/.config/$$r"; \
	  if [ -L "$$d" ]; then echo "  linked   $$r"; \
	  elif [ -e "$$d" ]; then echo "  NOT LINK $$r  (real file in ~/.config)"; \
	  else echo "  missing  $$r"; fi; \
	done; fi
