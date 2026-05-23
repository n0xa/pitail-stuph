#!/bin/sh
# Run this on the Pi to install the announce-ip service
# Supports Kali (NetworkManager) and Raspberry Pi OS (dhcpcd)
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Run as root: sudo sh install.sh"
    exit 1
fi

# Ensure curl is available
if ! command -v curl >/dev/null 2>&1; then
    echo "Installing curl..."
    apt-get update -qq && apt-get install -y -qq curl
fi

# Ensure wireless-tools is available (for iwgetid)
if ! command -v iwgetid >/dev/null 2>&1; then
    echo "Installing wireless-tools..."
    apt-get update -qq && apt-get install -y -qq wireless-tools
fi

# Detect wireless interface
WLAN=""
for iface in wlan0 wlan1; do
    if [ -d "/sys/class/net/$iface" ]; then
        WLAN="$iface"
        break
    fi
done
if [ -z "$WLAN" ]; then
    echo "Warning: No wireless interface found. Defaulting to wlan0."
    WLAN="wlan0"
fi

# Install main script with detected interface
sed "s/wlan0/$WLAN/g" announce-ip.sh > /usr/local/bin/announce-ip.sh
chmod 755 /usr/local/bin/announce-ip.sh

# Prompt for Pushover credentials if config doesn't exist
if [ ! -f /etc/announce-ip.conf ]; then
    printf "Pushover App Token: "
    read -r TOKEN
    printf "Pushover User Key: "
    read -r USER_KEY

    if [ -z "$TOKEN" ] || [ -z "$USER_KEY" ]; then
        echo "Error: Both token and user key are required" >&2
        exit 1
    fi

    cat > /etc/announce-ip.conf <<EOF
# /etc/announce-ip.conf
PUSHOVER_TOKEN="$TOKEN"
PUSHOVER_USER="$USER_KEY"
EOF
    chmod 600 /etc/announce-ip.conf
    echo "Credentials saved to /etc/announce-ip.conf"
else
    echo "/etc/announce-ip.conf already exists, skipping"
fi

# Install systemd service
cp announce-ip.service /etc/systemd/system/announce-ip.service
systemctl daemon-reload
systemctl enable announce-ip.service

# Install network change hook (detect NetworkManager vs dhcpcd)
if [ -d /etc/NetworkManager/dispatcher.d ]; then
    sed "s/wlan0/$WLAN/g" announce-ip-nm-hook.sh > /etc/NetworkManager/dispatcher.d/99-announce-ip
    chmod 755 /etc/NetworkManager/dispatcher.d/99-announce-ip
    echo "Installed NetworkManager dispatcher hook ($WLAN)"
elif [ -d /lib/dhcpcd/dhcpcd-hooks ]; then
    cp announce-ip-dhcp-hook.sh /lib/dhcpcd/dhcpcd-hooks/99-announce-ip
    chmod 755 /lib/dhcpcd/dhcpcd-hooks/99-announce-ip
    echo "Installed dhcpcd hook"
else
    echo "Warning: No NetworkManager or dhcpcd found. Only boot announcements will work."
fi

# Send first announcement now
echo ""
echo "Sending test announcement..."
if /usr/local/bin/announce-ip.sh; then
    echo "Success! Check your Pushover notifications."
else
    echo "Announcement failed. Verify your credentials in /etc/announce-ip.conf"
    echo "and that $WLAN has an IP address."
fi
