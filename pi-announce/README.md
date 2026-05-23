# pi-announce

Pushover-based IP announcement for headless Raspberry Pi devices on networks with dynamic/randomized subnets (e.g. GrapheneOS hotspots).

On boot or DHCP lease change, the Pi sends a Pushover notification with its IP, SSID, and gateway.

## Prerequisites

- A [Pushover](https://pushover.net) account ($5 one-time, per-platform)
- A Pushover application — create one at https://pushover.net/apps/build
- Note your **App Token** and **User Key**

## Install

Copy this directory to the Pi, then:

```sh
sudo ./install.sh
```

The installer will:
- Prompt for your Pushover App Token and User Key
- Install the announcement script and systemd service
- Install a NetworkManager or dhcpcd hook for lease change announcements
- Send a test notification

## Uninstall

```sh
sudo ./uninstall.sh
```

Removes the service, hooks, script, and credentials.

## How it works

- **Boot**: systemd oneshot runs after `network-online.target`
- **Lease change**: NetworkManager dispatcher (Kali) or dhcpcd hook (Raspberry Pi OS) triggers on DHCP events
- **Notification**: low-priority Pushover message with IP, SSID, and gateway

## Supported distros

- Kali Linux (NetworkManager)
- Raspberry Pi OS (dhcpcd)
