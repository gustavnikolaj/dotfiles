# omarchy-quattro

Config for Omarchy 4.x (quattro), whose Hyprland setup uses Lua
(`hyprland.lua`) instead of the old `hyprland.conf`.

## Usage

Only files I actually customize live in `config/<app>/`. Everything else stays
as the Omarchy default in `~/.config/<app>/`.

To start managing a file:

    mkdir -p config/foot
    cp ~/.config/foot/foot.ini config/foot/
    make install

`make install` symlinks each file in `config/<app>/` into `~/.config/<app>/`,
replacing whatever is at the destination, so edits in either location are the
same file.

    make          # show what is managed and whether it is linked
    make install  # create/refresh the symlinks

## Notes

- Omarchy defaults are loaded by `~/.config/hypr/hyprland.lua` via
  `require("default.hypr.omarchy")`. Files here only add overrides on top.
- `omarchy refresh config <app>/<file>` replaces a symlink with a real file.
  Re-run `make install` afterwards.
- The terminal is foot; run `omarchy restart terminal` to reload running
  windows after a `foot.ini` change.
- `reference/` (gitignored) holds the pre-quattro `.conf` files, kept only
  while porting. Delete it when done.
