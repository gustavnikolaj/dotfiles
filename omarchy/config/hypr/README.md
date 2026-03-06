These are my modifications to the omarchy hyprland setup. I wish that there was
a nicer way to manage this. It is intended to just modify things in place in
the .config/ files. Maybe I should just adopt those into my dotfiles directly?

Should probably use symlinks instead of install to get the hypr conf file in place...

```
$(DEST): $SRC
    ln -sf $(SRC) $(DEST)
```