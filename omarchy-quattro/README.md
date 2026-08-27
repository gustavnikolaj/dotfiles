# omarchy-quattro

Hyprland config for Omarchy 4.x (quattro), which uses Lua (`hyprland.lua`)
instead of the old `hyprland.conf`.

## Usage

Only files I actually customize live in `config/hypr/`. Everything else stays
as the Omarchy default in `~/.config/hypr/`.

To start managing a file:

    cp ~/.config/hypr/bindings.lua config/hypr/
    make install

`make install` symlinks each file in `config/hypr/` into `~/.config/hypr/`, so
edits in either location are the same file.

    make          # show what is managed and whether it is linked
    make install  # create/refresh the symlinks

## Notes

- Omarchy defaults are loaded by `~/.config/hypr/hyprland.lua` via
  `require("default.hypr.omarchy")`. Files here only add overrides on top.
- `omarchy refresh config hypr/<file>` replaces a symlink with a real file.
  Re-run `make install` afterwards.
- `reference/` (gitignored) holds the pre-quattro `.conf` files, kept only
  while porting. Delete it when done.
