-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- US primary, Danish second. Switch with both Shifts (grp:shifts_toggle).
    kb_layout = "us,dk",

    -- This replaces Omarchy's default of
    -- "compose:caps,shift:both_capslock_cancel", so both Shifts no longer
    -- toggles Caps Lock, and Compose moves off Caps Lock to the Menu key:
    --   ctrl:nocaps          Caps Lock acts as Ctrl
    --   compose:menu         Menu key is Compose
    --   altwin:swap_alt_win  Alt and Win swap, so physical Alt fires the
    --                        SUPER + ... bindings
    --   grp:shifts_toggle    both Shifts switches layout
    --
    -- Compose lives on Menu rather than Right Alt because Right Alt is
    -- already Super_R here (via altwin:swap_alt_win) and is AltGr on the dk
    -- layout. compose:ralt would override the symbol but not the Mod4
    -- modifier_map, leaving Right Alt as Compose and Super at once.
    --
    -- Note this drops altwin:menu_win, so the Menu key no longer acts as
    -- Super.
    kb_options = "ctrl:nocaps,compose:menu,altwin:swap_alt_win,grp:shifts_toggle",
  },
})
