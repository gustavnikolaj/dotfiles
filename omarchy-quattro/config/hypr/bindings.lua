-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- Slack. Omarchy binds SUPER + SHIFT + G to Signal by default, so drop that
-- first. The workspace rule sends Slack to its own named workspace.
hl.unbind("SUPER + SHIFT + G")
o.bind("SUPER + SHIFT + G", "Slack", { launch = "slack", focus = "slack" })
o.window("^(slack)$", { workspace = "name:Slack" })

-- Obsidian on SUPER + SHIFT + R, in addition to Omarchy's default
-- SUPER + SHIFT + O. Both focus an existing window before launching a new one,
-- so the two keys reach the same window.
o.bind("SUPER + SHIFT + R", "Obsidian", { launch = "obsidian", focus = "^obsidian$" })
o.window("^(obsidian)$", { workspace = "name:R" })
