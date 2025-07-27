#!/bin/bash

# Plymouth setup from omarchy.
# Source: https://github.com/basecamp/omarchy/blob/f25be1d07546b284785978150e3ebab37133319a/install/config/plymouth.sh

if ! command -v plymouth &>/dev/null; then
  yay -S --noconfirm --needed plymouth

  # Skip if plymouth already exists for some reason
  # Backup original mkinitcpio.conf just in case
  backup_timestamp=$(date +"%Y%m%d%H%M%S")
  sudo cp /etc/mkinitcpio.conf "/etc/mkinitcpio.conf.bak.${backup_timestamp}"

  # Add plymouth to HOOKS array after 'base udev' or 'base systemd'
  if grep "^HOOKS=" /etc/mkinitcpio.conf | grep -q "base systemd"; then
    sudo sed -i '/^HOOKS=/s/base systemd/base systemd plymouth/' /etc/mkinitcpio.conf
  elif grep "^HOOKS=" /etc/mkinitcpio.conf | grep -q "base udev"; then
    sudo sed -i '/^HOOKS=/s/base udev/base udev plymouth/' /etc/mkinitcpio.conf
  else
    echo "Couldn't add the Plymouth hook"
  fi

  # Regenerate initramfs
  sudo mkinitcpio -P

  # Add kernel parameters for Plymouth (systemd-boot only)
  if [ -d "/boot/loader/entries" ]; then
    echo "Detected systemd-boot"

    for entry in /boot/loader/entries/*.conf; do
      if [ -f "$entry" ]; then
        # Skip fallback entries
        if [[ "$(basename "$entry")" == *"fallback"* ]]; then
          echo "Skipped: $(basename "$entry") (fallback entry)"
          continue
        fi

        # Skip if splash it already present for some reason
        if ! grep -q "splash" "$entry"; then
          sudo sed -i '/^options/ s/$/ splash quiet/' "$entry"
        else
          echo "Skipped: $(basename "$entry") (splash already present)"
        fi
      fi
    done
  elif [ -f "/etc/default/grub" ]; then
    echo "Detected grub"
    # Backup GRUB config before modifying
    backup_timestamp=$(date +"%Y%m%d%H%M%S")
    sudo cp /etc/default/grub "/etc/default/grub.bak.${backup_timestamp}"

    # Check if splash is already in GRUB_CMDLINE_LINUX_DEFAULT
    if ! grep -q "GRUB_CMDLINE_LINUX_DEFAULT.*splash" /etc/default/grub; then
      # Get current GRUB_CMDLINE_LINUX_DEFAULT value
      current_cmdline=$(grep "^GRUB_CMDLINE_LINUX_DEFAULT=" /etc/default/grub | cut -d'"' -f2)

      # Add splash and quiet if not present
      new_cmdline="$current_cmdline"
      if [[ ! "$current_cmdline" =~ splash ]]; then
        new_cmdline="$new_cmdline splash"
      fi

      # Trim any leading/trailing spaces
      new_cmdline=$(echo "$new_cmdline" | xargs)

      sudo sed -i "s/^GRUB_CMDLINE_LINUX_DEFAULT=\".*\"/GRUB_CMDLINE_LINUX_DEFAULT=\"$new_cmdline\"/" /etc/default/grub

      # Regenerate grub config
      sudo grub-mkconfig -o /boot/grub/grub.cfg
    else
      echo "GRUB already configured with splash kernel parameters"
    fi
  else
    echo ""
    echo "Neither systemd-boot nor GRUB detected. Please manually add these kernel parameters:"
    echo "  - splash (to see the graphical splash screen)"
    echo "  - quiet (for silent boot)"
    echo ""
  fi

    sudo plymouth-set-default-theme -R text
fi
