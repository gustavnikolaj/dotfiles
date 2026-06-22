# hypridle fix: external monitor USB hub dying on idle

Date applied: 2026-06-22

## Problem

ThinkPad runs with the lid closed, driving a Dell UltraSharp U2722DE over USB-C.
The keyboard is plugged into the monitor's built-in USB hub (the KVM-style switch).

After 5 minutes idle, hypridle locked the screen and then ran `dpms off` on the
external output. With no video signal the U2722DE drops into deep standby, and in
that state it powers down its USB hub, so the keyboard goes dead. That left no way
to wake the machine except opening the lid to use the built-in keyboard.

The monitor is already on the latest firmware (M3T106) and exposes no OSD option
(no "Fast Wakeup", no "USB in standby") to keep the hub powered, so the fix has to
be on the laptop side: stop blanking the external output at idle.

## What was changed

File: `~/.config/hypr/hypridle.conf` (the LIVE file, edited directly).

The 5-minute idle listener was changed from:

    on-timeout = omarchy-system-lock

to:

    on-timeout = OMARCHY_LOCK_ONLY=true omarchy-system-lock

`OMARCHY_LOCK_ONLY=true` makes `omarchy-system-lock` lock the session but skip the
"turn the display off" step (see `cat $(which omarchy-system-lock)`). The screen
still locks; the external monitor stays lit on the lock screen instead of going to
`dpms off`, so the monitor never enters the deep standby that kills the hub.

Tradeoff: the monitor stays on at full brightness while locked (more idle power,
some long-term burn-in risk).

A timestamped backup of the pre-fix file was made:
`~/.config/hypr/hypridle.conf.bak.1782110851`

## How to undo the fix

Option A, revert just the one line. Edit `~/.config/hypr/hypridle.conf` and change
the 5-minute listener's `on-timeout` back to:

    on-timeout = omarchy-system-lock

Option B, restore the full backup:

    cp ~/.config/hypr/hypridle.conf.bak.1782110851 ~/.config/hypr/hypridle.conf

Either way, restart hypridle so it re-reads the config (it does not auto-reload):

    pkill -x hypridle; (hypridle &)

## IMPORTANT: this fix is NOT tracked by the dotfiles repo

The edit was made to the live `~/.config/hypr/hypridle.conf`, which is a plain file,
not a symlink from dotfiles. The repo's own copy at
`omarchy/config/hypr/hypridle.conf` is a stale, older snapshot and does NOT contain
this change.

Consequence: running `make hypr` in `~/dotfiles/omarchy` will overwrite the live
file with that stale copy and silently undo this fix (and revert to the older
hypridle layout). If you want the fix to survive `make hypr`, sync the live file
into the repo first:

    cp ~/.config/hypr/hypridle.conf ~/dotfiles/omarchy/config/hypr/hypridle.conf
