-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- US primary, Danish second. Switch with both Shifts (grp:shifts_toggle).
    kb_layout = "us,dk",

    -- This replaces Omarchy's default of
    -- "compose:caps,shift:both_capslock_cancel", so there is no Compose key
    -- and both Shifts no longer toggles Caps Lock. Both of those defaults
    -- want keys this setup uses for something else:
    --   ctrl:nocaps        Caps Lock acts as Ctrl (so Caps is not Compose)
    --   altwin:menu_win    Menu key acts as Super
    --   altwin:swap_alt_win  Alt and Super swap, so physical Alt fires the
    --                        SUPER + ... bindings
    --   grp:shifts_toggle  both Shifts switches layout (so not Caps Lock)
    kb_options = "ctrl:nocaps,altwin:menu_win,altwin:swap_alt_win,grp:shifts_toggle",
  },
})
