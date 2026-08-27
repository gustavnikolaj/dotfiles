-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- Slack and Obsidian each get their own workspace, numbered high (51, 52) to
-- stay clear of the 1-9 range used for regular work. The bar widget only
-- renders workspaces 1-10, so these two never show up there; reach them with
-- the bindings below, which focus the running window if there is one.

-- Slack. Omarchy binds SUPER + SHIFT + G to Signal by default, so drop that
-- binding first.
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Slack", { launch = "slack", focus = "slack" })
o.window("^(slack)$", { workspace = "51" })

-- Obsidian on SUPER + SHIFT + R, in addition to Omarchy's default
-- SUPER + SHIFT + O.
--
-- Obsidian reports its class as md.obsidian.Obsidian, not obsidian, so a plain
-- ^(obsidian)$ match never fires. Omarchy's own SUPER + SHIFT + O binding still
-- uses that stale match, so it launches a second copy instead of focusing the
-- running one.
o.bind("SUPER + SHIFT + R", "Obsidian", { launch = "obsidian", focus = "^md\\.obsidian\\.Obsidian$" })
o.window("^md\\.obsidian\\.Obsidian$", { workspace = "52" })

-- Toggle the Elgato key lights. ~/dotfiles/bin/lights defaults to toggle when
-- called with no arguments.
--
-- Resolved off ~/dotfiles/omarchy/bin, which is prepended to the session PATH
-- by ~/.config/uwsm/env.d/99-omarchy-upgrade-env and holds a symlink to the
-- real script. ~/dotfiles/bin itself is only on the interactive shell PATH, so
-- a bare `lights` would otherwise silently do nothing here.
o.bind("F7", "Key lights", "lights")

-- Toggle software monitoring of the Svive USB mic into the FiiO DAC. See
-- ~/dotfiles/mic-monitor/README.md. Same PATH story as F7: the script lives in
-- ~/.local/bin, which the session PATH does not have, so the keybind resolves
-- it through the symlink at omarchy/bin/mic-monitor.
o.bind("F8", "Mic monitor", "mic-monitor toggle")
