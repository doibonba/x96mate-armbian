#!/usr/bin/env bash
set -u

section() {
  printf '\n========== %s ==========\n' "$1"
}

section VERSION
cat /etc/armbian-release 2>/dev/null || true
cat /etc/os-release 2>/dev/null || true
uname -a

section MODEL
printf 'MODEL: '
tr -d '\0' < /proc/device-tree/model 2>/dev/null || true
printf '\nCOMPATIBLE: '
tr '\0' ' ' < /proc/device-tree/compatible 2>/dev/null || true
printf '\n'

section BOOT
cat /boot/armbianEnv.txt 2>/dev/null || true
cat /proc/cmdline 2>/dev/null || true
findmnt / 2>/dev/null || true
findmnt /boot 2>/dev/null || true

section STORAGE
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINTS,MODEL 2>/dev/null || true
blkid 2>/dev/null || true

section MMC
ls -l /dev/mmcblk* 2>/dev/null || true
dmesg | grep -Ei 'mmc|emmc|sunxi.*mmc|sun50i|sdhci' | tail -n 220 || true

section NETWORK
ip -br link 2>/dev/null || true
ip -br addr 2>/dev/null || true

section LAN_DMESG
dmesg | grep -Ei 'eth|ethernet|dwmac|stmmac|gmac|emac|mdio|phy|rtl820|rtl821' | tail -n 260 || true

section USB
lsusb 2>/dev/null || true

section THERMAL
for z in /sys/class/thermal/thermal_zone*/temp; do
  [[ -r "$z" ]] || continue
  printf '%s: ' "$z"
  awk '{printf "%.1f C\n", $1/1000}' "$z" 2>/dev/null || cat "$z"
done

section MEMORY_CPU
free -h 2>/dev/null || true
lscpu 2>/dev/null || true

section DONE
echo 'Attach this output for Build 1 review.'
