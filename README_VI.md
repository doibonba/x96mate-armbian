# X96 Mate H616 — Noble Server 2026.08 (Baseline Build 1)

Bộ starter này dùng **Armbian build chính thức** để tạo image baseline cho X96 Mate:

- Board: `x96-mate`
- SoC: Allwinner H616
- Userspace: Ubuntu Noble 24.04
- Kiểu image: Server, không Desktop
- Architecture: arm64
- Kernel branch: `current`
- Tên artifact dễ nhận: `Armbian_noble_arm64_server_2026.08_x96-mate_baseline.img.xz`

> `2026.08` ở đây là nhãn dự án/tên file. Revision Armbian bên trong image được action chính thức tự xác định tại thời điểm build.

## Mục tiêu của Build 1

Build này **chưa cố sửa LAN onboard và chưa cố sửa boot eMMC**. Mục tiêu là có một baseline Noble mới, boot bằng **thẻ SD khác**, rồi kiểm tra CPU/RAM/SD/eMMC/USB/HDMI/reboot/nhiệt độ.

Giữ nguyên thẻ SD cũ đang boot được làm **rescue**. Không chạy `armbian-install` vào eMMC ở giai đoạn này.

## Cách build bằng GitHub Actions

1. Tạo một repository GitHub mới, ví dụ `x96mate-armbian`.
2. Upload **toàn bộ nội dung** thư mục này vào repository, bao gồm thư mục ẩn `.github`.
3. Vào tab **Actions**.
4. Chọn workflow **Build X96 Mate Noble 2026.08**.
5. Chọn **Run workflow**.
6. Chờ job hoàn tất.
7. Ở trang run, tải artifact:
   `Armbian_noble_arm64_server_2026.08_x96-mate_baseline`
8. Giải nén artifact để lấy:
   `Armbian_noble_arm64_server_2026.08_x96-mate_baseline.img.xz`

Workflow cũng tạo một GitHub **pre-release** với tag:
`x96mate-noble-2026.08-baseline`.

## Ghi image

Dùng một **thẻ SD khác** với thẻ rescue hiện tại. Ghi file `.img.xz` bằng công cụ ghi image bạn quen dùng trên Windows.

Lần test đầu nên cắm:
- HDMI/serial nếu có
- USB-LAN đang hoạt động
- Không ghi gì vào eMMC

## Kiểm tra sau khi boot

Chép `scripts/x96mate-firstboot-test.sh` lên box hoặc copy nội dung rồi chạy:

```bash
sudo bash x96mate-firstboot-test.sh | tee x96mate-noble-test.txt
```

Sau đó gửi `x96mate-noble-test.txt` để phân tích.

### Build 1 được coi là đạt nếu

- Boot được từ SD.
- `/proc/device-tree/model` nhận X96 Mate.
- eMMC 32 GB xuất hiện trong `lsblk`.
- USB-LAN hoạt động.
- USB/HDMI/console không có lỗi nghiêm trọng.
- Reboot được ổn định.
- Nhiệt độ hợp lý khi idle.

**LAN onboard chưa phải tiêu chí pass của Build 1.** Với H616 EMAC1 `ethernet@5030000`, Armbian hiện có issue riêng cho external RMII và nêu X96 Mate trong nhóm board bị ảnh hưởng. Vì vậy patch LAN sẽ làm ở Build 2 sau khi baseline chạy ổn.

## Thư mục `reference/`

Đây là backup từ bản Jammy hiện đang chạy trên chính box:

- `armbian-release`
- `armbianEnv.txt`
- `boot.cmd`
- `boot.scr`
- `sun50i-h616-x96-mate.dtb`
- `x96mate-running.dts`

Các file này **chỉ để đối chiếu/debug**, workflow baseline không chép chúng đè lên image mới.

## `userpatches/`

Armbian GitHub Action tự đồng bộ thư mục `userpatches/` của repository vào build tree. Hiện thư mục này chỉ có ghi chú và **không chứa patch LAN giả định**. Khi xác định được patch đúng cho EMAC1/RMII, ta sẽ đặt patch vào đây và giữ nguyên workflow.

## `ophub-experimental/`

Có một dòng model database thử nghiệm để chuẩn bị cho bước repack bằng Ophub sau này. **Chưa dùng nó để build/repack lúc này**, vì Ophub cần bộ U-Boot tương ứng cho board Allwinner và X96 Mate chưa có entry chính thức trong database hiện tại.
