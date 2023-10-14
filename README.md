# pital-stuph
Scripts and Tips for Kali Linux Pi-Tail Edition

# Documentation
* [Pi-Tail for Pi Zero W](https://www.kali.org/docs/arm/raspberry-pi-zero-w-pi-tail/)
* [Pi-Tail for Pi Zero 2 W](https://www.kali.org/docs/arm/raspberry-pi-zero-2-w-pi-tail/)

# Drivers and Downloads
* [All Raspberry Pi Kali Editions](https://www.kali.org/get-kali/#kali-arm)
* [8821au](https://github.com/morrownr/8812au-20210629) driver for Alfa AWUS036ACS and similar USB adapters, enables monitor and packet injection mode

# Android Apps
* [ConnectBot](https://play.google.com/store/apps/details?id=org.connectbot&hl=en_US&gl=US&pli=1)
  * SSH Client
  * Port Forwarding 
* [bVNC](https://play.google.com/store/apps/details?id=com.iiordanov.freebVNC&hl=en_US&gl=US)
  * Graphical interface
  * Slow on a Pi Zero W. More tolerable on the Zero 2, Pi3 or Pi4 models
* [Hacker's Keyboard](https://play.google.com/store/apps/details?id=org.pocketworkstation.pckeyboard&hl=en_US&gl=US)
  * Full-featured five-row keyboard with arrow and meta keys
  * Useful for special characters needed for advanced command-line usage
  * Consider carrying an portable external keyboard
* [GPSd Client /  Forwarder](https://play.google.com/store/apps/details?id=io.github.tiagoshibata.gpsdclient&hl=en_US&gl=US)
  * Sends your phone's GPS data to a UDP listener on Kali Pi-Tail
  * Enables wardriving without a hardware GPS Receiver on the Pialfa-mon.sh
# Included Scripts
* alfa.sh
  * Loads 8821au kernel module and brings up wlan1 in normal mode (no IP address) 
* alfa-mon.sh
  * Loads 8821au kernel module and brings up wlan1 in monitor mode for kismet, wifite, aircrack-ng, etc
* kismet.sh
  * Starts a GPSd server listening for the Android GPSd Forwarder session, and launches Kismet on wlan1
* ktow.sh
  * Kismet-To-Wigle: convert .kismet log files to CSV files you can upload to WiGLE
* wigle-upload.sh
  * A fully-CLI-driven WiGLE uploader. Requires WiGLE API keys. Instructions in file comments