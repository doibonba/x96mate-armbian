# LAN patch placeholder — chưa áp dụng

Không đặt patch LAN đoán mò vào Build 1.

Máy hiện tại dùng onboard Ethernet tại `ethernet@5030000` / EMAC1, RMII. Bản Jammy cũ báo `No PHY found`. Armbian issue #10084 mô tả H616/H618 EMAC1 external RMII có vấn đề clock/syscon và nêu X96 Mate là ví dụ bị ảnh hưởng trên current 6.18 / edge 7.0.

Build 1 để xác nhận baseline Noble/current trước. Sau khi có dmesg/DT runtime từ image mới, tạo Build 2 với patch riêng.
