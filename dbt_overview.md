# Tổng quan về dbt (data build tool)

## 1. Tại sao lại dùng dbt?

dbt (data build tool) đã trở thành tiêu chuẩn trong ngành kỹ thuật dữ liệu (Data Engineering) hiện đại vì nó mang các tư duy của **Kỹ thuật phần mềm (Software Engineering)** áp dụng vào **Làm sạch và Biến đổi dữ liệu (Data Transformation)**.

Trước đây, việc biến đổi dữ liệu thường là các đoạn mã SQL rời rạc hoặc các Stored Procedures phức tạp, khó quản lý. dbt cho phép các Data Analyst và Data Engineer viết mã SQL theo cách có cấu trúc, có thể tái sử dụng và kiểm soát được phiên bản.

---

## 2. dbt ra đời nhằm giải quyết vấn đề gì?

Trước khi dbt xuất hiện, quy trình làm việc với dữ liệu thường gặp các "nỗi đau" sau:

*   **Spaghetti Code:** Các câu lệnh SQL dài hàng nghìn dòng, đan xen lẫn nhau, rất khó để hiểu hoặc sửa đổi mà không làm hỏng thứ khác.
*   **Thiếu kiểm soát phiên bản (Version Control):** Code biến đổi dữ liệu thường nằm trong các công cụ BI hoặc trực tiếp trong Database, không được lưu trên Git, dẫn đến việc khó track được ai đã thay đổi gì.
*   **Data Lineage mù mờ:** Không biết bảng A được tạo ra từ bảng B nào, dẫn đến việc khi thay đổi nguồn thì không biết các bảng phía sau bị ảnh hưởng ra sao.
*   **Thiếu Testing:** Dữ liệu bị sai (null, trùng lặp, sai logic) thường chỉ được phát hiện khi nó đã lên đến Dashboard.
*   **Tốn thời gian Documentation:** Việc viết tài liệu cho các bảng và cột thường bị bỏ qua vì quá tốn sức và nhanh chóng bị lạc hậu.

**dbt giải quyết những vấn đề này bằng cách:**
*   Sử dụng hàm `{{ ref(...) }}` để tự động xây dựng cây phụ thuộc (DAG).
*   Tích hợp chặt chẽ với Git.
*   Cung cấp framework testing tự động.
*   Tự động tạo Documentation từ code và file cấu hình YAML.

---

## 3. Ưu và nhược điểm của dbt

### Ưu điểm
*   **Ngôn ngữ SQL phổ biến:** Bất kỳ ai biết SQL đều có thể sử dụng dbt (Data Analyst, Analytics Engineer).
*   **Modularity (Tính module):** Chia nhỏ các biến đổi thành các model nhỏ, dễ quản lý và tái sử dụng.
*   **Tự động hóa:** Tự động tạo bảng/view dựa trên cấu hình, không cần viết lệnh `CREATE TABLE` thủ công.
*   **Testing & Documentation:** Biến việc kiểm tra dữ liệu và viết tài liệu thành một phần của quy trình phát triển.
*   **Cộng đồng lớn:** Có rất nhiều package hỗ trợ (như `dbt_utils`) giúp giải quyết các bài toán phổ biến nhanh chóng.

### Nhược điểm
*   **Chỉ tập trung vào chữ T (Transform):** dbt không giúp bạn lấy dữ liệu từ nguồn (Extract) hay đẩy vào kho (Load). Bạn vẫn cần các công cụ như Airbyte, Fivetran hoặc Spark để làm việc đó.
*   **Phụ thuộc vào Data Warehouse:** dbt đẩy toàn bộ tính toán xuống Database/Data Warehouse. Nếu database yếu, dbt sẽ không thể chạy nhanh được.
*   **Giới hạn về logic phức tạp:** Mặc dù dbt đã hỗ trợ Python model, nhưng SQL vẫn là chủ đạo. Với các logic xử lý dữ liệu phi cấu trúc hoặc Machine Learning phức tạp, dbt không mạnh bằng Spark.

---

## 4. So sánh dbt với các công cụ khác

| Đặc điểm | dbt | Stored Procedures | Apache Spark | GUI ETL (Informatica/Talend) |
| :--- | :--- | :--- | :--- | :--- |
| **Cách tiếp cận** | Code-based (SQL/Jinja) | Database-based (SQL) | Code-based (Python/Scala) | Drag-and-drop (GUI) |
| **Kiến trúc** | ELT (Transform trong Warehouse) | ELT | ETL (Xử lý ngoài Warehouse) | ETL |
| **Version Control** | Rất tốt (Git-native) | Khó (thường lưu trong DB) | Rất tốt | Khó (file binary) |
| **Data Lineage** | Tự động hoàn toàn | Phải vẽ tay | Phải dùng công cụ ngoài | Có tích hợp nhưng đóng kín |
| **Chi phí** | Thấp/Miễn phí (Open source) | Có sẵn trong DB | Cao (vận hành cluster) | Rất đắt (license) |
| **Đối tượng dùng** | Analyst, Analytics Engineer | DBA, Data Engineer | Data Engineer, Data Scientist | Data Engineer truyền thống |

### Khi nào chọn cái nào?
*   **Chọn dbt:** Khi bạn đã có Data Warehouse (BigQuery, Snowflake, Hive, Postgres...) và muốn chuẩn hóa quy trình biến đổi dữ liệu bằng SQL.
*   **Chọn Stored Procedures:** Chỉ dùng cho các logic cực kỳ đơn giản hoặc hệ thống cũ (legacy) không thể cài đặt thêm công cụ.
*   **Chọn Apache Spark:** Khi dữ liệu của bạn là phi cấu trúc, dung lượng khổng lồ (Petabytes) hoặc cần các logic tính toán phức tạp mà SQL không đáp ứng được.
*   **Chọn GUI ETL:** Khi doanh nghiệp có ngân sách lớn và đội ngũ không có kỹ năng lập trình/SQL mạnh, ưu tiên giao diện kéo thả.
