# Ophub experimental notes

Dòng `w209` trong file đi kèm là **dòng tự đề xuất**, không phải ID/entry chính thức của Ophub.

Không dùng nó cho repack production ở Build 1.

Lý do: model database hiện tại của Ophub có cấu trúc riêng cho Allwinner và dùng `BOOTLOADER_IMG=u-boot-sunxi-with-spl.bin`. Khi thêm board mới cần đi kèm device config, system files, U-Boot files và process control. Vì vậy chỉ thêm một dòng database là chưa đủ để đảm bảo image X96 Mate boot được.

Kế hoạch:
1. Build/boot baseline bằng Armbian official trước.
2. Xác nhận U-Boot/DTB/kernel mới trên chính box.
3. Làm LAN patch.
4. Sau đó mới đóng gói bộ U-Boot + model entry cho Ophub.
