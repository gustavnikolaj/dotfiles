# omarchy

Config for Omarchy 4.x (quattro), whose Hyprland setup uses Lua
(`hyprland.lua`) instead of the old `hyprland.conf`.

## Usage

Only files I actually customize live in `config/<app>/`. Everything else stays
as the Omarchy default in `~/.config/<app>/`.

To start managing a file:

    mkdir -p config/foot
    cp ~/.config/foot/foot.ini config/foot/
    make install

`make install` symlinks each file under `config/` into the matching path in
`~/.config/`, replacing whatever is at the destination, so edits in either
location are the same file. Nested paths work, so `config/uwsm/env.d/50-dotfiles`
lands at `~/.config/uwsm/env.d/50-dotfiles`.

    make          # show what is managed and whether it is linked
    make install  # create/refresh the symlinks

## Notes

- Omarchy defaults are loaded by `~/.config/hypr/hyprland.lua` via
  `require("default.hypr.omarchy")`. Files here only add overrides on top.
- `omarchy refresh config <app>/<file>` replaces a symlink with a real file.
  Re-run `make install` afterwards.
- The terminal is foot; run `omarchy restart terminal` to reload running
  windows after a `foot.ini` change.
- `config/uwsm/env.d/50-dotfiles` sets the session PATH. uwsm launches the
  session and sources `~/.config/uwsm/env.d/*` from
  `uwsm aux prepare-env`, so changes there need a full session restart --
  `hyprctl reload` will not pick them up.
- `bin/` is on the session PATH (see `50-dotfiles`), so keybindings and
  desktop entries can call its scripts by bare name. Several entries are
  relative symlinks to scripts living elsewhere in the repo.
- `make applications` installs the webapps, the Outlook desktop entry and
  its `mailto:` handler from `applications/` and `install/`. It is separate
  from `make install` and only needs re-running when those change.
