# Cẩm Nang Cài Đặt & Chạy AFFiNE (Phiên bản Custom Cloud 1000GB)
*Tài liệu dành cho người mới bắt đầu, không yêu cầu kiến thức lập trình phức tạp.*

Tài liệu này sẽ hướng dẫn bạn cách thiết lập và tự chạy toàn bộ hệ thống AFFiNE (giống như Notion nhưng có thêm tính năng bảng vẽ) trên chính máy tính của bạn. Bạn sẽ có trọn vẹn 1000GB lưu trữ đám mây (Cloud) để chia sẻ ghi chú giữa máy tính và điện thoại.

---

## 🛠️ PHẦN 1: Chuẩn bị các phần mềm nền tảng
*Nếu máy bạn đã có sẵn, hãy bỏ qua phần này.*

**1. Cài đặt Node.js (Môi trường chạy code)**
- Vào trang chủ: [nodejs.org](https://nodejs.org/en)
- Tải phiên bản **v22.x** (hoặc v20.x) có chữ "LTS" (Bản ổn định).
- Cài đặt bình thường bằng cách ấn Next liên tục.
- Sau khi cài xong, bạn cần tải trình quản lý gói `Yarn`. Bấm phím `Windows` -> Gõ `cmd` -> Mở **Command Prompt**.
- Trong Command Prompt, gõ lệnh này và ấn Enter: `npm install -g yarn`

**2. Cài đặt Docker Desktop (Dùng để chạy hệ thống Dữ liệu - Database)**
- Vào trang: [docker.com](https://www.docker.com/products/docker-desktop)
- Tải và cài đặt Docker Desktop. 
- **Quan trọng:** Sau khi cài xong, bạn phải **mở phần mềm Docker Desktop lên** và để nó chạy ngầm (thấy icon chú cá voi ở góc phải màn hình).

**3. Cài đặt Git (Tùy chọn)**
- Dùng để tải code từ mạng về máy. Tải tại [git-scm.com](https://git-scm.com/downloads).

---

## 📥 PHẦN 2: Tải Code và Cài đặt

**Bước 1: Tải mã nguồn về máy**
- Mở thư mục bạn muốn lưu code (ví dụ: ổ `D:\`), nhấp chuột phải chọn **Open in Terminal** (hoặc Open Git Bash here).
- Gõ lệnh tải code (Thay link bằng link kho chứa của bạn):
  ```cmd
  git clone https://github.com/leanhvu17023010/affine.git
  ```
- Hoặc nếu không dùng Git, bạn có thể lên trang GitHub, bấm nút **Code xanh lá cây** -> Chọn **Download ZIP**, sau đó giải nén ra máy.

**Bước 2: Cài đặt thư viện**
- Dùng Terminal/Command Prompt (CMD) di chuyển vào thư mục code vừa tải:
  ```cmd
  cd affine
  ```
- Gõ lệnh cài đặt tất cả thư viện (quá trình này mất khoảng 2-5 phút, hãy kiên nhẫn):
  ```cmd
  yarn install
  ```

---

## ⚙️ PHẦN 3: Cấu hình Mạng (Để dùng chung cho Điện thoại)

Để điện thoại của bạn có thể vào được hệ thống, máy tính và điện thoại **phải kết nối chung một mạng WiFi**. Bạn cần tìm địa chỉ IP của máy tính:

**Bước 1: Tìm IP máy tính**
- Bấm phím `Windows` -> Gõ `cmd` -> Mở **Command Prompt**.
- Gõ lệnh: `ipconfig`
- Tìm đến dòng có chữ **IPv4 Address**. Nó sẽ có dạng `192.168.x.x` (Ví dụ: `192.168.1.5`). Ghi nhớ dãy số này.

**Bước 2: Điền IP vào cấu hình AFFiNE**
- Bật thư mục code `affine` của bạn lên. 
- Đi theo đường dẫn: `packages` -> `backend` -> `server`.
- Tìm file có tên `.env` (mở bằng Notepad hoặc bất kỳ trình soạn thảo chữ nào).
- Tìm dòng `AFFINE_SERVER_EXTERNAL_URL=` và sửa thành:
  ```env
  AFFINE_SERVER_EXTERNAL_URL="http://192.168.1.5:8080"
  ```
  *(Thay `192.168.1.5` bằng số IP bạn vừa tìm thấy ở trên).*

---

## 🗄️ PHẦN 4: Khởi động Database (Cơ sở dữ liệu)

1. Đảm bảo phần mềm **Docker Desktop** đang mở và chạy.
2. Từ thư mục `affine` trên Terminal, chạy lần lượt 3 lệnh sau để khởi động Database:
   ```cmd
   cd .docker/dev
   docker compose up -d
   cd ../..
   ```
3. Sau khi Docker khởi động xong, chạy lệnh này để cài đặt các "bảng" lưu trữ cho Database:
   ```cmd
   yarn affine server init
   ```

*(Ghi chú: Nếu hệ thống báo thiếu bảng Database tên là `workspace_sync_permission_generations` - hãy yên tâm, đây là lỗi phổ biến. Bạn chỉ cần chạy lệnh sau để phục hồi bảng đó:)*
```cmd
cd packages/backend/server
yarn prisma db execute --file migrations/20260829120000_terminal_authority_and_resource_ledger/migration.sql --schema schema.prisma
cd ../../..
```

---

## 🚀 PHẦN 5: Chạy Hệ Thống

Để hệ thống hoạt động, ta cần **2 cái khiêng** (2 cửa sổ lệnh) chạy cùng lúc. Không được tắt chúng khi đang sử dụng.

### 🟡 Cửa sổ 1: Chạy Máy Chủ Dữ Liệu (Backend)
- Mở một Terminal / CMD tại thư mục `affine`.
- Gõ lệnh:
  ```cmd
  set HOST=0.0.0.0
  yarn affine server dev
  ```
  *(Dành cho máy dùng PowerShell: gõ `$env:HOST="0.0.0.0"; yarn affine server dev`)*
- Đợi 1 lúc, khi màn hình hiện dòng chữ **`Server is listening on port 3010`** là thành công.

### 🟢 Cửa sổ 2: Chạy Giao Diện Web (Frontend)
- Mở thêm 1 cửa sổ Terminal / CMD mới (vẫn ở thư mục `affine`).
- Gõ lệnh:
  ```cmd
  yarn dev -p @affine/web
  ```
- Đợi đến khi màn hình báo **`ready in ... ms`** và có chữ **`http://localhost:8080`**.

---

## 🎉 PHẦN 6: Thưởng Thức

**1. Sử dụng trên Máy Tính:**
- Mở trình duyệt web (Chrome, Cốc Cốc, Edge).
- Gõ vào thanh địa chỉ: `http://localhost:8080` (hoặc `http://192.168.1.5:8080`).

**2. Sử dụng trên Điện Thoại / Tablet:**
- Kết nối chung mạng WiFi với máy tính.
- Mở Safari hoặc Chrome trên điện thoại, gõ địa chỉ IP của máy tính cộng với cổng `8080`.
- Ví dụ: `http://192.168.1.5:8080`.

**3. Đăng ký & Nhận 1000GB Cloud:**
- Ở góc trên cùng bên trái màn hình, bấm vào chữ "AFFiNE" hoặc Avatar.
- Đăng ký một tài khoản bất kỳ (không cần email thật, chỉ cần hệ thống của riêng bạn ghi nhận).
- Đăng nhập vào.
- Tạo một thư mục làm việc (Workspace) dạng "Local".
- Bấm chọn thư mục đó và ấn vào nút **"Enable Cloud"**.
- Chờ vài giây để dữ liệu đồng bộ. Bây giờ bạn đã sở hữu 1000GB không gian lưu trữ đồng bộ mọi thiết bị!
