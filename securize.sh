#!/bin/bash

#Usage:
#bash securize.sh [/path/to/system/image]

#cleanups
umount d

set -ex

origin="$(readlink -f -- "$0")"
origin="$(dirname "$origin")"

if [ -f "$1" ];then
    srcFile="$1"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: sudo bash securize.sh [/path/to/system.img]"
	exit 1
fi

simg2img "$srcFile" s-secure.img || cp "$srcFile" s-secure.img

rm -Rf tmp
mkdir -p d tmp
e2fsck -y -f s-secure.img
resize2fs s-secure.img 5000M
e2fsck -E unshare_blocks -y -f s-secure.img
mount -o loop,rw s-secure.img d

touch d/system/phh/secure
rm d/system/xbin/su
rm d/system/bin/phh-su
rm d/system/etc/init/su.rc
rm d/system/bin/phh-securize.sh
rm -Rf d/system/{app,priv-app}/me.phh.superuser/

sleep 1

if [ ! -z "$2" ]; then
    rm -rf d/system/product/overlay/treble-overlay-infinix-*
    rm -rf d/system/product/overlay/treble-overlay-lenovo-*
    rm -rf d/system/product/overlay/treble-overlay-lge-*
    rm -rf d/system/product/overlay/treble-overlay-asus-*
    rm -rf d/system/product/overlay/treble-overlay-xiaomi-*
    rm -rf d/system/product/overlay/treble-overlay-samsung-*
    rm -rf d/system/product/overlay/treble-overlay-sony-*    
    rm -rf d/system/product/overlay/treble-overlay-tecno-*
    rm -rf d/system/product/overlay/treble-overlay-realme-*
    rm -rf d/system/product/overlay/treble-overlay-oppo-*
    rm -rf d/system/product/overlay/treble-overlay-nokia-*
    rm -rf d/system/product/overlay/treble-overlay-oneplus-* 
    rm -rf d/system/product/overlay/treble-overlay-nubia-*       
    rm -rf d/system/product/overlay/treble-overlay-moto-*    
    rm -rf d/system/product/overlay/treble-overlay-lg-*
    rm -rf d/system/product/overlay/treble-overlay-htc-*
    rm -rf d/system/product/overlay/treble-overlay-blackview-*
    rm -rf d/system/product/overlay/treble-overlay-vivo-*
    rm -rf d/system/product/overlay/treble-overlay-vsmart-*
    rm -rf d/system/product/overlay/treble-overlay-razer-*
    rm -rf d/system/product/overlay/treble-overlay-sharp-*
	rm -rf d/system/system_ext/apex/com.android.vndk.v32
	rm -rf d/system/system_ext/apex/com.android.vndk.v31
	rm -rf d/system/system_ext/apex/com.android.vndk.v30
	rm -rf d/system/system_ext/apex/com.android.vndk.v29
fi

umount d

e2fsck -f -y s-secure.img || true
resize2fs -M s-secure.img
