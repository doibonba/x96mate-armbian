# Build plan

## Build 1 — baseline
- Armbian official build framework
- BOARD=x96-mate
- RELEASE=noble
- BRANCH=current
- server image
- SD boot only for testing
- USB-LAN fallback
- no eMMC installation
- no custom LAN patch

## Build 2 — LAN investigation/patch
Collect from Build 1:
- `/etc/armbian-release`
- `uname -a`
- runtime DTS/DTB
- `dmesg` for `5030000.ethernet`
- `ip -br link`

Then compare current kernel DTS/driver with the known H616 EMAC1 RMII issue before adding a patch under `userpatches/`.

## Build 3 — eMMC boot
Only after Build 1/2 are stable. Keep the known-good rescue SD untouched until eMMC standalone boot is proven.
