#!/bin/sh
# dhcpcd hook - re-announce IP on lease bound/renew
# Installed to /lib/dhcpcd/dhcpcd-hooks/99-announce-ip

case "$reason" in
    BOUND|RENEW|REBIND)
        /usr/local/bin/announce-ip.sh &
        ;;
esac
