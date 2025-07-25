#!/usr/bin/env bash
# disable-usb-ethernet.sh
# Disables Realtek USB Ethernet device (0bda:8153) via udev rule

RULE_FILE="/etc/udev/rules.d/99-disable-usb-ethernet.rules"

# Check if rule file already exists
if [ -f "$RULE_FILE" ]; then
  echo "Udev rule already exists at $RULE_FILE. Skipping."
  exit 0
fi

# Create the rule with sudo
echo "Creating udev rule to disable Realtek USB Ethernet adapter..."
sudo bash -c "cat > $RULE_FILE" <<EOF
SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8153", ATTR{authorized}="0"
EOF

# Reload udev rules
echo "Reloading udev rules..."
sudo udevadm control --reload
sudo udevadm trigger

echo "Done. The Realtek USB Ethernet adapter should now be disabled."
