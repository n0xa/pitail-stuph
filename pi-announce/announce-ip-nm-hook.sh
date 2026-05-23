#!/bin/sh
# NetworkManager dispatcher hook - re-announce IP on connectivity changes
# Installed to /etc/NetworkManager/dispatcher.d/99-announce-ip

INTERFACE="$1"
ACTION="$2"

case "$ACTION" in
    up|dhcp4-change)
        if [ "$INTERFACE" = "wlan0" ]; then
            /usr/local/bin/announce-ip.sh &
        fi
        ;;
esac
