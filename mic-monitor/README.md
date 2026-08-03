# mic-monitor

Low-latency headphone monitoring for the Svive USB condenser mic, which has no
hardware monitor output of its own.

## Install

```
$ make install
```

That symlinks `mic-monitor` into `~/.local/bin` (already on `PATH` via the bash
setup). Symlinked rather than copied, so edits in this repo take effect
immediately with no reinstall step. No `sudo` needed: nothing here touches
`/etc` or `/usr`, unlike `../webcam-c920`.

```
$ make uninstall
```

Stops a running monitor and removes the symlink. It refuses to delete
`~/.local/bin/mic-monitor` if it is a real file rather than a symlink, so it
cannot clobber something unrelated that ended up at that path.

## Usage

```
$ mic-monitor            # toggle
$ mic-monitor on|off
$ mic-monitor status
$ mic-monitor nodes      # list PipeWire node names, for when hardware changes
$ mic-monitor check      # show actual running quantum + xrun counters
```

It is deliberately on-demand rather than autostarted, for two reasons: you do
not usually want to hear yourself, and the low quantum it forces is wasteful for
ordinary desktop audio (see below).

## Keybinding

**F8** toggles the monitor, bound in
`../omarchy/config/hypr/bindings.conf` next to the existing F9 (dictation) and
F10 (AI) keys, since all three are voice-related. F8 was free, and F11/F12 were
avoided because applications claim them for fullscreen and devtools.

There is a trap here worth remembering. Hyprland's session PATH is *not* your
shell's PATH:

```
$ tr '\0' '\n' < /proc/$(pgrep -x Hyprland)/environ | grep ^PATH=
```

It contains `~/dotfiles/omarchy/bin` but **not** `~/.local/bin`, so a keybind
calling a bare `mic-monitor` would silently do nothing. Hence
`../omarchy/bin/mic-monitor`, a *relative* symlink back to this folder, which is
committed so a fresh clone gets a working keybind with no install step. That is
the same reason `improve-selection` on F10 resolves.

So there are two entry points to one script, serving two different PATHs:

| Link | For | Created by |
| --- | --- | --- |
| `~/.local/bin/mic-monitor` | interactive shells | `make install` |
| `../omarchy/bin/mic-monitor` | Hyprland keybinds | committed to git |

Because a keybind has no terminal to print to, the script sends a desktop
notification instead when stdout is not a tty. Repeated toggles replace the
previous notification rather than stacking, via
`x-canonical-private-synchronous`.

## Why this exists

The Svive USB condenser mic (`31b2:0011`, reported as `DCMT Technology USB
Condenser Microphone`) is **capture-only**. Confirmed three ways:

- `/proc/asound/Microphone/` contains only `pcm0c`. No playback PCM node.
- Its USB descriptors expose one audio streaming interface, endpoint `0x81
  (1 IN)`. There is no OUT streaming interface, so the host has no way to send
  audio back to the mic.
- Its USB mixer has exactly two controls, `Mic Capture Volume` and
  `Mic Capture Switch`. No headphone or monitor volume.

So there is no 3.5mm monitor jack to use, and no amount of configuration creates
one. Monitoring has to happen in software: mic -> PipeWire -> a separate DAC.
Here that DAC is the FiiO E10 (`alsa_output.usb-FiiO_DigiHug_USB_Audio-01`).

For contrast, Svive's Hydra Essential and Hydra Pro *do* have a 3.5mm TRS jack
plus a headphone volume knob, which is why their monitoring is genuinely
zero-latency and needs none of this.

## Why the quantum matters

The first attempt at this loopback was abandoned as unusably laggy. The cause
was not the loopback itself but the graph quantum: the desktop default is
`clock.quantum = 1024`, which at 48kHz is **21.3ms per leg**. A loopback pays
that twice, plus ALSA buffering at each end, landing somewhere around 45-55ms.
That is well past the roughly 20ms where hearing your own voice starts feeling
wrong.

At `QUANTUM=128` the budget is:

| Stage | Latency |
| --- | --- |
| Mic ALSA capture (period 64 + headroom 64) | ~2.7ms |
| Graph, capture leg | 2.67ms |
| Graph, playback leg | 2.67ms |
| FiiO ALSA playback (period 64 + headroom 64) | ~2.7ms |
| **Total** | **~9-11ms** |

Roughly a 5x improvement, and comparable to standing 3m from a wall and hearing
the reflection. Measured headroom at this setting was large: 0.2us busy against
a 20.8us wait, `B/Q 0.00`.

The script sets `node.latency` on both loopback streams instead of forcing
`clock.quantum` globally. That pulls the whole graph down to 128 only while the
monitor is running, and leaves the desktop back at 1024 the rest of the time,
which is better for battery and avoids needlessly waking the CPU for music
playback.

## Tuning

`QUANTUM` is the single knob; `latency_ms()` derives pw-loopback's millisecond
argument from it so the two cannot drift apart.

```
$ MIC_MONITOR_QUANTUM=64 mic-monitor on   # ~6ms, roughly half
$ mic-monitor check                       # then confirm err stays flat
```

In `check` output, the `err` column is the xrun counter. A small constant value
is fine, those are one-off negotiation hits at startup. A value that *climbs*
between samples means the quantum is too low and you will hear crackling. The
thing most likely to bite here is that both the mic and the FiiO are full-speed
(USB 1.1) devices behind the ThinkPad Thunderbolt dock's hub chain, which adds
scheduling jitter that a directly-attached device would not have.

## Volume

The monitor was initially too quiet, because the signal is attenuated twice
before it reaches your ears:

| Stage | Level |
| --- | --- |
| Mic source | 0.64 |
| Loopback capture stream | 1.00 |
| Loopback playback stream | 1.00 (now `GAIN`) |
| FiiO sink | 0.80 |
| Effective monitor path | 0.64 x 0.80 = **0.51** |

So monitoring sat at about half unity. `GAIN` is applied to the loopback's
*playback stream* to compensate. The default of **1.2** was arrived at by ear,
not by the arithmetic above, which would have suggested nearer 1.9. Tune it live
while talking:

```
$ mic-monitor gain        # read current
$ mic-monitor gain 2.0    # set, takes effect immediately
```

Live changes are not persisted; set `MIC_MONITOR_GAIN` or edit `GAIN` in the
script to make one stick.

The gain is deliberately on the loopback stream and not on the two obvious
alternatives:

- Raising the **mic source** (0.64) would also change what listeners hear.
- Raising the **FiiO sink** (0.80) would make all your other audio louder too.

One caveat worth knowing. This is digital amplification *after* capture, so it
makes monitoring louder without improving the signal itself; it lifts the noise
floor along with your voice. If other people on a call also say you are quiet,
the fix is the mic's own gain, not this: turn up the knob on the mic, or raise
the mic source itself, which was found sitting at 0.64. Note that wpctl only
takes numeric ids, and those are reassigned every session, so look it up rather
than hardcoding it:

```
$ wpctl status | grep -i condenser        # find the current id
$ wpctl set-volume <id> 0.9               # changes recordings too, not just monitoring
```

Use `GAIN` only when it is specifically the monitor that is too quiet.

## Limits

Below roughly 6ms, software cannot help. The mic and the FiiO are independent
USB devices in separate clock domains, one `ASYNC` and one `ADAPTIVE`, so
PipeWire is resampling between them regardless of settings. True zero-latency
monitoring is inherently analog: the mic splits the signal to a headphone jack
before it is ever digitised. If ~6ms still bothers you, that is a hardware
purchase, not a config change.

## Changing hardware

Both node names are hardcoded defaults and both contain device serials, so they
will break if the mic or the DAC is replaced. Run `mic-monitor nodes` to get the
new names, then either edit `SOURCE` / `SINK` at the top of the script or
override per-run:

```
$ MIC_MONITOR_SOURCE=alsa_input.some-other-mic mic-monitor on
```

## Related

- `../webcam-c920` - same shape of problem for the C920, but installs system-wide
  via udev and systemd because it has to run on device hotplug.
