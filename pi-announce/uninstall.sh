#!/bin/sh
# Completely remove announce-ip service, hooks, config, and script
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root: sudo sh uninstall.sh"
    exit 1
fi

# Stop and disable systemd service
if systemctl is-active announce-ip.service >/dev/null 2>&1; then
    systemctl stop announce-ip.service
    echo "Stopped announce-ip.service"
fi
if systemctl is-enabled announce-ip.service >/dev/null 2>&1; then
    systemctl disable announce-ip.service
    echo "Disabled announce-ip.service"
fi

# Remove systemd unit
rm -f /etc/systemd/system/announce-ip.service
systemctl daemon-reload
echo "Removed systemd service"

# Remove NetworkManager dispatcher hook
if [ -f /etc/NetworkManager/dispatcher.d/99-announce-ip ]; then
    rm -f /etc/NetworkManager/dispatcher.d/99-announce-ip
    echo "Removed NetworkManager dispatcher hook"
fi

# Remove dhcpcd hook
if [ -f /lib/dhcpcd/dhcpcd-hooks/99-announce-ip ]; then
    rm -f /lib/dhcpcd/dhcpcd-hooks/99-announce-ip
    echo "Removed dhcpcd hook"
fi

# Remove script
rm -f /usr/local/bin/announce-ip.sh
echo "Removed /usr/local/bin/announce-ip.sh"

# Remove config (contains API keys)
if [ -f /etc/announce-ip.conf ]; then
    rm -f /etc/announce-ip.conf
    echo "Removed /etc/announce-ip.conf"
fi

echo ""
echo "Fully uninstalled."
