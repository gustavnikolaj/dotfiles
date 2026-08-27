# Symlinks everything in config/hypr/ into ~/.config/hypr/.
# To manage a new file: copy it into config/hypr/, then run `make install`.

HYPR_SRC := $(wildcard config/hypr/*)
HYPR_DST := $(patsubst config/hypr/%,$(HOME)/.config/hypr/%,$(HYPR_SRC))

.PHONY: default install status

default: status
	@echo
	@echo "Run 'make install' to (re)create the symlinks."

install: $(HYPR_DST)

$(HOME)/.config/hypr/%: config/hypr/%
	ln -sfn $(CURDIR)/$< $@

status:
	@echo "Managed here:"
	@if [ -z "$(HYPR_SRC)" ]; then echo "  (nothing yet)"; \
	else for f in $(HYPR_SRC); do \
	  d="$(HOME)/.config/hypr/$$(basename $$f)"; \
	  if [ -L "$$d" ]; then echo "  linked   $$(basename $$f)"; \
	  elif [ -e "$$d" ]; then echo "  NOT LINK $$(basename $$f)  (real file in ~/.config/hypr)"; \
	  else echo "  missing  $$(basename $$f)"; fi; \
	done; fi
