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

-- Hold a logind block inhibitor on the lid switch, so locking the screen in
-- clamshell does not suspend the machine out from under a running agent.
--
-- The chain it breaks: locking blanks the displays 5s later, the Dell drops its
-- DP link in standby, logind stops seeing an external display, and the closed
-- lid then means suspend. See ~/dotfiles/bin/stay-docked for the long version.
--
-- The bar's Stay Awake coffee cup does not cover this: it only disables the
-- shell's idle timers and never touches logind.
--
-- Same PATH story as F7 and F8: the script lives in ~/dotfiles/bin, which is
-- not on the session PATH, so this resolves through the symlink at
-- ~/dotfiles/omarchy/bin/stay-docked. Defaults to toggle with no arguments.
o.bind("F6", "Stay docked", "stay-docked")

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

-- Rewrite the highlighted text with an AI model and paste it back over the
-- selection. See ~/dotfiles/omarchy/bin/improve-selection. Sibling to F9
-- dictation, which stays an Omarchy default.
--
-- Not made redundant by quattro's new SUPER + SHIFT + CTRL + A "Agent"
-- binding: that opens a coding agent in a terminal and has no notion of the
-- current selection.
o.bind("F10", "Improve selection (AI)", "improve-selection")

-- ─── BEGIN vim-style SUPER + HJKL navigation ─────────────────────────────────
--
-- Everything down to the END fence is one unit. Quattro has no plugin
-- mechanism for shipping a self-contained bundle of bindings, so it lives
-- inline here; if one ever lands, move the whole fenced block rather than
-- picking it apart. Ported from the pre-quattro
-- ~/dotfiles/omarchy/config/hypr/vim-navigation.conf.
--
-- What it does: mirror Omarchy's SUPER + arrow bindings on hjkl. The arrow
-- keys keep working as alternatives. Workspace switching is deliberately not
-- part of this and stays numeric (SUPER + 1..0, SUPER + TAB, SUPER + scroll).
--
-- Three upstream defaults sit on J, K and L and have to move first. Finding a
-- home for the third one costs a fourth relocation:
--
--   SUPER + J            Toggle window split      ->  SUPER + Y
--   SUPER + L            Toggle workspace layout  ->  SUPER + U
--   SUPER + K            Keybindings              ->  SUPER + SLASH
--   SUPER + SLASH        Monitor scaling up       ->  dropped
--   SUPER + ALT + SLASH  Monitor scaling down     ->  dropped
--
-- Dropping monitor scaling is the same trade the Omarchy 3 config made. It is
-- still reachable from the display menu on SUPER + CTRL + D.
--
-- Simpler than the .conf version was: quattro binds monitor scaling by the
-- SLASH name, so the old code:61 keycode unbinds and the case-sensitive
-- "SUPER, Slash" duplicate are no longer needed.
--
-- hl.unbind clears every bind on a chord, including ones set earlier in this
-- file, so all the unbinds come before the rebinds.

hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")
hl.unbind("SUPER + SLASH")
hl.unbind("SUPER + ALT + SLASH")

o.bind("SUPER + Y", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + U", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + SLASH", "Keybindings", "omarchy-menu-keybindings")

-- Focus movement, mirroring SUPER + arrows.
o.bind("SUPER + H", "Move focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move focus right", hl.dsp.focus({ direction = "r" }))

-- Window swapping, mirroring SUPER + SHIFT + arrows.
o.bind("SUPER + SHIFT + H", "Swap window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window right", hl.dsp.window.swap({ direction = "r" }))

-- Extensions, left off. These mirror three more sets of arrow bindings, but
-- each costs relocations that have not felt worth it so far. Conflicts below
-- are current as of quattro.
--
-- Move into group, mirrors SUPER + ALT + arrows.
-- Displaces SUPER + ALT + K (Tmux keybindings).
-- o.bind("SUPER + ALT + H", "Move window to group on left", hl.dsp.window.move({ into_group = "l" }))
-- o.bind("SUPER + ALT + J", "Move window to group below", hl.dsp.window.move({ into_group = "d" }))
-- o.bind("SUPER + ALT + K", "Move window to group above", hl.dsp.window.move({ into_group = "u" }))
-- o.bind("SUPER + ALT + L", "Move window to group on right", hl.dsp.window.move({ into_group = "r" }))
--
-- Move workspace to monitor, mirrors SUPER + SHIFT + ALT + arrows.
-- No conflicts, all four chords are free.
-- o.bind("SUPER + SHIFT + ALT + H", "Move workspace to left monitor", hl.dsp.workspace.move({ monitor = "l" }))
-- o.bind("SUPER + SHIFT + ALT + J", "Move workspace to below monitor", hl.dsp.workspace.move({ monitor = "d" }))
-- o.bind("SUPER + SHIFT + ALT + K", "Move workspace to above monitor", hl.dsp.workspace.move({ monitor = "u" }))
-- o.bind("SUPER + SHIFT + ALT + L", "Move workspace to right monitor", hl.dsp.workspace.move({ monitor = "r" }))
--
-- Group navigation, mirrors SUPER + CTRL + LEFT/RIGHT.
-- Displaces SUPER + CTRL + H (Hardware menu) and SUPER + CTRL + L (Lock system).
-- o.bind("SUPER + CTRL + H", "Move grouped window focus left", hl.dsp.group.prev())
-- o.bind("SUPER + CTRL + L", "Move grouped window focus right", hl.dsp.group.next())
--
-- ─── END vim-style SUPER + HJKL navigation ───────────────────────────────────
