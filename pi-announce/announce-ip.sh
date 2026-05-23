#!/bin/sh
# announce-ip.sh - Send Pi's IP address via Pushover notification
# Deploy to headless Raspberry Pi, configure with your Pushover credentials

PUSHOVER_TOKEN="${PUSHOVER_TOKEN:-}"
PUSHOVER_USER="${PUSHOVER_USER:-}"
CONFIG_FILE="/etc/announce-ip.conf"

# Load config file if it exists
if [ -f "$CONFIG_FILE" ]; then
    . "$CONFIG_FILE"
fi

if [ -z "$PUSHOVER_TOKEN" ] || [ -z "$PUSHOVER_USER" ]; then
    echo "Error: PUSHOVER_TOKEN and PUSHOVER_USER must be set in $CONFIG_FILE" >&2
    exit 1
fi

# Wait for an IP on wlan0 (up to 30 seconds)
TRIES=0
while [ $TRIES -lt 15 ]; do
    IP=$(ip -4 addr show wlan0 2>/dev/null | grep -oP 'inet \K[0-9.]+')
    [ -n "$IP" ] && break
    TRIES=$((TRIES + 1))
    sleep 2
done

if [ -z "$IP" ]; then
    echo "Error: No IP on wlan0 after 30s" >&2
    exit 1
fi

HOSTNAME=$(hostname)
GATEWAY=$(ip route show default 2>/dev/null | awk '{print $3; exit}')
SSID=$(iwgetid -r 2>/dev/null || echo "unknown")

curl -s \
    --form-string "token=$PUSHOVER_TOKEN" \
    --form-string "user=$PUSHOVER_USER" \
    --form-string "title=$HOSTNAME online" \
    --form-string "message=$IP on $SSID (gw $GATEWAY)" \
    --form-string "priority=-1" \
    https://api.pushover.net/1/messages.json > /dev/null

echo "Announced: $IP on $SSID"
