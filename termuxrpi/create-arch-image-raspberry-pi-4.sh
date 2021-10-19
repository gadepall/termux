#script to create an archlinux image for RPi4
#By GVV Sharma
#October 18 2021

#Adapted from
#https://gist.github.com/larsch/4ae5499023a3c5e22552
#for android termux
#you need to enter the ssid and passwd manually so that  you  may connect
#to your rpi wirelessly from the phone
#!/bin/sh -ex
image=arch-linux-$(date +%Y%m%d).img
wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz
truncate -s 2G $image
losetup /dev/block/loop0 $image
parted -s /dev/block/loop0 mklabel msdos
parted -s /dev/block/loop0 unit s mkpart primary fat32 -- 1 524288
parted -s /dev/block/loop0 set 1 boot on
parted -s /dev/block/loop0 unit s mkpart primary ext4 -- 524289 -2
parted -s /dev/block/loop0 print
mkfs.vfat -I -n SYSTEM /dev/block/loop0p1
mkfs.ext4 -F -L root -b 4096 -E stride=4,stripe_width=1024 /dev/block/loop0p2
mkdir -p root
mount /dev/block/loop0p2 root
#bsdtar -xpf ArchLinuxARM-rpi-aarch64-latest.tar.gz -C root
tar xfz ArchLinuxARM-rpi-aarch64-latest.tar.gz -C root
mv root/boot root/boot-temp
mkdir -p root/boot
mount /dev/block/loop0p1 root/boot
mv root/boot-temp/* root/boot/
rm -rf root/boot-temp
#sed -i "s/ defaults / defaults,noatime /" root/etc/fstab
sed -i 's/mmcblk0/mmcblk1/g' root/etc/fstab
SSID="ssid"
PASS="passwd"
cat << EOF >> root/etc/systemd/network/wlan0.network
[Match]
Name=wlan0

[Network]
DHCP=yes
EOF
cat << EOF >> root/etc/wpa_supplicant/wpa_supplicant-wlan0.conf
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
  scan_ssid=1
  ssid="${SSID}"
  psk="${PASS}"
}
EOF
#
#wpa_passphrase "${SSID}" "${PASS}" > root/etc/wpa_supplicant/wpa_supplicant-wlan0.conf
#
ln -s \
   /usr/lib/systemd/system/wpa_supplicant@.service \
   root/etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service
#
echo Unmounting
umount root/boot root

echo Cleaning up
rmdir root

#losetup -d /dev/block/loop0
