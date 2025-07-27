#!/bin/bash

# Seamless login from omarchy.
# Source: https://github.com/basecamp/omarchy/blob/f25be1d07546b284785978150e3ebab37133319a/install/config/login.sh

yay -S --noconfirm --needed uwsm

# Compile the seamless login helper -- needed to prevent seeing terminal between loader and desktop
cat <<'CCODE' >/tmp/seamless-login.c
/*
 * Seamless Login - Minimal SDDM-style Plymouth transition
 * Replicates SDDM's VT management for seamless auto-login
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/kd.h>
#include <linux/vt.h>
#include <sys/wait.h>
#include <string.h>

int main(int argc, char *argv[]) {
    int vt_fd;
    int vt_num = 1; // TTY1
    char vt_path[32];
    
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <session_command>\n", argv[0]);
        return 1;
    }
    
    // Open the VT (simple approach like SDDM)
    snprintf(vt_path, sizeof(vt_path), "/dev/tty%d", vt_num);
    vt_fd = open(vt_path, O_RDWR);
    if (vt_fd < 0) {
        perror("Failed to open VT");
        return 1;
    }
    
    // Activate the VT
    if (ioctl(vt_fd, VT_ACTIVATE, vt_num) < 0) {
        perror("VT_ACTIVATE failed");
        close(vt_fd);
        return 1;
    }
    
    // Wait for VT to be active
    if (ioctl(vt_fd, VT_WAITACTIVE, vt_num) < 0) {
        perror("VT_WAITACTIVE failed");
        close(vt_fd);
        return 1;
    }
    
    // Critical: Set graphics mode to prevent console text
    if (ioctl(vt_fd, KDSETMODE, KD_GRAPHICS) < 0) {
        perror("KDSETMODE KD_GRAPHICS failed");
        close(vt_fd);
        return 1;
    }
    
    // Clear VT and close (like SDDM does)
    const char *clear_seq = "\33[H\33[2J";
    if (write(vt_fd, clear_seq, strlen(clear_seq)) < 0) {
        perror("Failed to clear VT");
    }
    
    close(vt_fd);
    
    // Set working directory to user's home
    const char *home = getenv("HOME");
    if (home) chdir(home);
    
    // Now execute the session command
    execvp(argv[1], &argv[1]);
    perror("Failed to exec session");
    return 1;
}
CCODE

gcc -o /tmp/seamless-login /tmp/seamless-login.c
sudo mv /tmp/seamless-login /usr/local/bin/seamless-login
sudo chmod +x /usr/local/bin/seamless-login
rm /tmp/seamless-login.c

cat <<EOF | sudo tee /etc/systemd/system/omarchy-seamless-login.service
[Unit]
Description=Omarchy Seamless Auto-Login
Documentation=https://github.com/basecamp/omarchy
Conflicts=getty@tty1.service
After=systemd-user-sessions.service getty@tty1.service plymouth-quit.service systemd-logind.service
PartOf=graphical.target

[Service]
Type=simple
ExecStart=/usr/local/bin/seamless-login uwsm start -- hyprland.desktop
Restart=always
RestartSec=2
User=$USER
TTYPath=/dev/tty1
TTYReset=yes
TTYVHangup=yes
TTYVTDisallocate=yes
StandardInput=tty
StandardOutput=journal
StandardError=journal+console
PAMName=login

[Install]
WantedBy=graphical.target
EOF

# Make plymouth remain until graphical.target
sudo mkdir -p /etc/systemd/system/plymouth-quit.service.d
sudo tee /etc/systemd/system/plymouth-quit.service.d/wait-for-graphical.conf <<'EOF'
[Unit]
After=multi-user.target
EOF

# Prevent plymouth-quit-wait.service
sudo systemctl mask plymouth-quit-wait.service

sudo systemctl daemon-reload
sudo systemctl enable omarchy-seamless-login.service

# Disable getty@tty1 to prevent conflicts
sudo systemctl disable getty@tty1.service
