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

mkdir -p d/system/phh
touch d/system/phh/secure
rm d/system/xbin/su || true
rm d/system/bin/phh-su || true
rm d/system/etc/init/su.rc || true
rm d/system/bin/phh-securize.sh || true
rm -Rf d/system/{app,priv-app}/me.phh.superuser/ || true

sleep 1

if [ $2 = "huawei" ]; then
    rm -rf d/system/product/overlay/treble-overlay-infinix-* || true
    rm -rf d/system/product/overlay/treble-overlay-lenovo-* || true
    rm -rf d/system/product/overlay/treble-overlay-lge-* || true
    rm -rf d/system/product/overlay/treble-overlay-asus-* || true
    rm -rf d/system/product/overlay/treble-overlay-xiaomi-* || true
    rm -rf d/system/product/overlay/treble-overlay-samsung-* || true
    rm -rf d/system/product/overlay/treble-overlay-sony-* || true
    rm -rf d/system/product/overlay/treble-overlay-tecno-* || true
    rm -rf d/system/product/overlay/treble-overlay-realme-* || true
    rm -rf d/system/product/overlay/treble-overlay-oppo-* || true
    rm -rf d/system/product/overlay/treble-overlay-nokia-* || true
    rm -rf d/system/product/overlay/treble-overlay-oneplus-* || true
    rm -rf d/system/product/overlay/treble-overlay-nubia-* || true
    rm -rf d/system/product/overlay/treble-overlay-moto-* || true
    rm -rf d/system/product/overlay/treble-overlay-lg-* || true
    rm -rf d/system/product/overlay/treble-overlay-htc-* || true
    rm -rf d/system/product/overlay/treble-overlay-blackview-* || true
    rm -rf d/system/product/overlay/treble-overlay-vivo-* || true
    rm -rf d/system/product/overlay/treble-overlay-vsmart-* || true
    rm -rf d/system/product/overlay/treble-overlay-razer-* || true
    rm -rf d/system/product/overlay/treble-overlay-sharp-* || true
fi

if [ $3 = "28" ]; then
    rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
    rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
    rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
    rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
fi

sleep 1

umount d

e2fsck -f -y s-secure.img || true
resize2fs -M s-secure.img
