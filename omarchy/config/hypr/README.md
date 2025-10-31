These are my adaptions to the keybindings. 

I will need to polish the set integration at a later point. It could probably be
done cleaner with more targeted changes, where instead of sourcing my modified
files I would unbind and rebind functionailty.

Should probably use symlinks instead of install to get the hypr conf file in place...

```
$(DEST): $SRC
    ln -sf $(SRC) $(DEST)
```