#!/bin/bash
# Starts GPSd monitoring for your GPSd-Forwarder session
# On Android, set GPSd Forwarder to the IP Address of Pi-Tail and port 9999
# Then run this program. Make sure wlan1 is in monitor mode. You may wish 
# to modify the interface name (e.g. mon1) depending on your hardware and
# configuration
gpsd udp://*:9999
kismet -c wlan1
