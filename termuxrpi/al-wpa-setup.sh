#script to connect to new network in archlinuxarm for RPi4
#By GVV Sharma
#October 26 2021

#usage:  
#chmod +x al-wpa-setup.sh
#./al-wpa-setup.sh  wifi_name wifi_password

#Adapted from
#https://ladvien.com/installing-arch-linux-raspberry-pi-zero-w/

#!/bin/sh -ex

# SSID="ssid"
# PASS="passwd"

set -e

SSID="$1"
PASS="$2"

wpa_passphrase "${SSID}" "${PASS}" >> /etc/wpa_supplicant/wpa_supplicant-wlan0.conf


