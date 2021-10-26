#script to connect to new network in archlinuxarm for RPi4
#By GVV Sharma
#October 26 2021

#usage:  
#chmod +x al-wpa-setup.sh
#./al-wpa-setup.sh /dev/sdb wifi_name wifi_password

#Adapted from
#https://ladvien.com/installing-arch-linux-raspberry-pi-zero-w/
#for android termux
#you need to enter the ssid and passwd manually so that  you  may connect
#to your rpi wirelessly from the phone

#!/bin/sh -ex

# SSID="ssid"
# PASS="passwd"

set -e

SSID="$1"
PASS="$2"

wpa_passphrase "${SSID}" "${PASS}" > root/etc/wpa_supplicant/wpa_supplicant-wlan0.conf


