# Source: https://wiki.archlinux.org/index.php/GNOME_Keyring
# Start a D-Bus session
source /etc/X11/Xsession.d/75dbus_dbus-launch
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK

gnome-settings-daemon &
gnome-sound-applet &
nm-applet &

xsetroot -solid "#333333"

exec i3
