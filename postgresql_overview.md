# Tổng quan về PostgreSQL

## 1. Tại sao lại dùng PostgreSQL?

PostgreSQL (thường gọi là Postgres) được mệnh danh là "Hệ quản trị cơ sở dữ liệu quan hệ mã nguồn mở tiên tiến nhất thế giới". Trong dự án này, Postgres đóng vai trò là **Metastore** cho Hive – nơi lưu trữ toàn bộ thông tin về "tọa độ" dữ liệu, cấu trúc bảng và kiểu dữ liệu.

Postgres được tin dùng bởi sự ổn định tuyệt đối, tuân thủ chặt chẽ các tiêu chuẩn SQL và khả năng mở rộng cực kỳ mạnh mẽ mà không tốn chi phí bản quyền.

---

## 2. PostgreSQL ra đời nhằm giải quyết vấn đề gì?

Postgres ra đời (từ dự án POSTGRES tại UC Berkeley) để giải quyết những hạn chế của các hệ thống cơ sở dữ liệu quan hệ (RDBMS) đời đầu:

*   **Sự thiếu linh hoạt của kiểu dữ liệu:** Các DB cũ chỉ hỗ trợ các kiểu dữ liệu cơ bản (số, chữ). Postgres cho phép định nghĩa các kiểu dữ liệu phức tạp hơn như hình học, mạng, và sau này là JSONB.
*   **Tính toàn vẹn dữ liệu:** Đảm bảo dữ liệu luôn chính xác ngay cả khi hệ thống gặp sự cố đột ngột thông qua cơ chế ACID (Atomicity, Consistency, Isolation, Durability) cực kỳ nghiêm ngặt.
*   **Khả năng mở rộng tính năng (Extensibility):** Cho phép người dùng tự viết các hàm (Functions), thủ tục (Stored Procedures) bằng nhiều ngôn ngữ như PL/pgSQL, Python, Perl... và tạo ra các Index tùy chỉnh.
*   **Chi phí bản quyền:** Cung cấp các tính năng mạnh mẽ tương đương với các giải pháp đắt tiền như Oracle hay SQL Server nhưng hoàn toàn miễn phí.

---

## 3. Ưu và nhược điểm của PostgreSQL

### Ưu điểm
*   **Độ tin cậy cực cao:** Rất ít khi xảy ra tình trạng hỏng dữ liệu (data corruption).
*   **Tính năng phong phú:** Hỗ trợ tốt cả dữ liệu quan hệ (SQL) và dữ liệu phi cấu trúc (NoSQL thông qua JSONB).
*   **Cộng đồng mạnh mẽ:** Có hàng nghìn tiện ích mở rộng (như PostGIS cho dữ liệu bản đồ, TimescaleDB cho dữ liệu chuỗi thời gian).
*   **Tuân thủ tiêu chuẩn:** Postgres thực hiện gần như đầy đủ các tiêu chuẩn SQL mới nhất (SQL:2023).
*   **Xử lý đồng thời (Concurrency):** Sử dụng cơ chế MVCC giúp nhiều người cùng đọc/ghi dữ liệu mà không gây khóa (lock) hệ thống lẫn nhau.

### Nhược điểm
*   **Hiệu năng ghi (Write performance):** Trong một số trường hợp ghi dữ liệu cực nhanh và đơn giản, Postgres có thể chậm hơn MySQL một chút do cơ chế đảm bảo an toàn dữ liệu phức tạp hơn.
*   **Độ phức tạp cấu hình:** Để đạt được hiệu năng tối ưu cho các hệ thống lớn, Postgres yêu cầu người quản trị phải hiểu sâu về các thông số cấu hình RAM/Disk.
*   **Kiến trúc Process-based:** Mỗi kết nối đến Postgres tạo ra một tiến trình (process) riêng, dẫn đến việc tiêu tốn RAM khi có hàng nghìn kết nối đồng thời (thường phải dùng thêm công cụ như PgBouncer).

---

## 4. So sánh PostgreSQL với các công cụ khác

| Đặc điểm | PostgreSQL | MySQL | Oracle Database | MongoDB (NoSQL) |
| :--- | :--- | :--- | :--- | :--- |
| **Loại** | Object-Relational | Relational | Object-Relational | Document-based |
| **Giấy phép** | Miễn phí (PostgreSQL License) | Miễn phí / Trả phí (Oracle) | Rất đắt | Miễn phí / Trả phí |
| **Tính năng JSON** | Rất mạnh (JSONB + Indexing) | Khá tốt | Có hỗ trợ | Tốt nhất |
| **Tính tuân thủ SQL** | Cao nhất | Trung bình | Cao | Không có (Dùng MQL) |
| **Độ ổn định** | Cực cao | Cao | Cực cao | Trung bình |

### Khi nào chọn cái nào?
*   **Chọn PostgreSQL:** Khi bạn cần một DB "nồi đồng cối đá", cần tính chính xác tuyệt đối, hoặc muốn dùng SQL để xử lý cả dữ liệu JSON. Đây là lựa chọn mặc định cho hầu hết các dự án Backend và Data Engineering hiện đại.
*   **Chọn MySQL:** Cho các website đơn giản, ứng dụng web ưu tiên tốc độ đọc/ghi cực nhanh và không cần quá nhiều tính năng phức tạp.
*   **Chọn Oracle:** Cho các tập đoàn khổng lồ đã quen với hệ sinh thái của Oracle và cần sự hỗ trợ 24/7 từ phía nhà cung cấp.
*   **Chọn MongoDB:** Khi dữ liệu thay đổi cấu trúc liên tục và không cần các mối quan hệ (Join) phức tạp giữa các bảng.
