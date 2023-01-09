#!/bin/bash

#Usage:
#bash featherize.sh [/path/to/system/image] [brand] [vndk]

#cleanups
umount d

set -ex

origin="$(readlink -f -- "$0")"
origin="$(dirname "$origin")"

[ ! -d vendor_vndk ] && git clone https://github.com/phhusson/vendor_vndk -b android-10.0

if [ -f "$1" ];then
	srcFile="$1"
	BRAND="$2"
	VNDK="$3"
fi

if [ ! -f "$srcFile" ];then
	echo "Usage: sudo bash featherize.sh [/path/to/system.img] [brand] [vndk]"
	exit 1
fi


simg2img "$srcFile" f.img || cp "$srcFile" f.img

rm -Rf tmp
mkdir -p d tmp
e2fsck -y -f f.img
resize2fs f.img 5000M
e2fsck -E unshare_blocks -y -f f.img
mount -o loop,rw f.img d

sleep 1

if [[ "$BRAND" != "asus" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-asus-*"`; do rm $f; done
fi
if [[ "$BRAND" != "blackview" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-blackview-*"`; do rm $f; done
fi
if [[ "$BRAND" != "bq" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-bq-*"`; do rm $f; done
fi
if [[ "$BRAND" != "duoqin" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-duoqin-*"`; do rm $f; done
fi
if [[ "$BRAND" != "essential" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-essential-*"`; do rm $f; done
fi
if [[ "$BRAND" != "fairphone" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-fairphone-*"`; do rm $f; done
fi
if [[ "$BRAND" != "htc" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-htc-*"`; do rm $f; done
fi
if [[ "$BRAND" != "huawei" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-huawei-*"`; do rm $f; done
fi
if [[ "$BRAND" != "infinix" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-infinix-*"`; do rm $f; done
fi
if [[ "$BRAND" != "lenovo" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-lenovo-*"`; do rm $f; done
fi
if [[ "$BRAND" != "lg" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-lg-*"`; do rm $f; done
fi
if [[ "$BRAND" != "lge" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-lge-*"`; do rm $f; done
fi
if [[ "$BRAND" != "mbi" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-mbi-*"`; do rm $f; done
fi
if [[ "$BRAND" != "meizu" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-meizu-*"`; do rm $f; done
fi
if [[ "$BRAND" != "moto" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-moto-*"`; do rm $f; done
fi
if [[ "$BRAND" != "nokia" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-nokia-*"`; do rm $f; done
fi
if [[ "$BRAND" != "nubia" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-nubia-*"`; do rm $f; done
fi
if [[ "$BRAND" != "oneplus" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-oneplus-*"`; do rm $f; done
fi
if [[ "$BRAND" != "oppo" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-oppo-*"`; do rm $f; done
fi
if [[ "$BRAND" != "oukitel" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-oukitel-*"`; do rm $f; done
fi
if [[ "$BRAND" != "razer" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-razer-*"`; do rm $f; done
fi
if [[ "$BRAND" != "realme" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-realme-*"`; do rm $f; done
fi
if [[ "$BRAND" != "samsung" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-samsung-*"`; do rm $f; done
fi
if [[ "$BRAND" != "sharp" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-sharp-*"`; do rm $f; done
fi
if [[ "$BRAND" != "sony" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-sony-*"`; do rm $f; done
fi
if [[ "$BRAND" != "teclast" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-teclast-*"`; do rm $f; done
fi
if [[ "$BRAND" != "tecno" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-tecno-*"`; do rm $f; done
fi
if [[ "$BRAND" != "teracube" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-teracube-*"`; do rm $f; done
fi
if [[ "$BRAND" != "umidigi" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-umidigi-*"`; do rm $f; done
fi
if [[ "$BRAND" != "unihertz" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-unihertz-*"`; do rm $f; done
fi
if [[ "$BRAND" != "vivo" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-vivo-*"`; do rm $f; done
fi
if [[ "$BRAND" != "vivo" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-vsmart-*"`; do rm $f; done
fi
if [[ "$BRAND" != "vivo" ]]; then
	for f in `find d/system/product/overlay -name "treble-overlay-xiaomi-*"`; do rm $f; done
fi

if [[ "$VNDK" == "28" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
elif [[ "$VNDK" == "29" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v28 || true
elif [[ "$VNDK" == "30" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v28 || true
elif [[ "$VNDK" == "31" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v28 || true
elif [[ "$VNDK" == "32" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v28 || true
elif [[ "$VNDK" == "33" ]]; then
	rm -rf d/system/system_ext/apex/com.android.vndk.v32 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v31 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v30 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v29 || true
	rm -rf d/system/system_ext/apex/com.android.vndk.v28 || true
fi

sleep 1

umount d

e2fsck -f -y f.img || true
resize2fs -M f.img
