# Giới thiệu Công nghệ & Kiến trúc Ứng dụng (dbt + Hive)

Tài liệu này giải thích chi tiết về các công cụ được sử dụng trong dự án, vai trò của chúng và cách chúng phối hợp để tạo nên một pipeline dữ liệu hoàn chỉnh.

## 1. Tổng quan Kiến trúc
Ứng dụng được xây dựng theo mô hình **Modern Data Stack** thu nhỏ, sử dụng Docker để giả lập môi trường Big Data chuyên nghiệp ngay trên máy cá nhân.

---

## 2. Các công cụ và Vai trò

### 🛠 dbt (data build tool)
- **Vai trò**: Tầng biến đổi dữ liệu (Transformation Layer).
- **Chức năng**:
    - Quản lý mã nguồn SQL theo các layer (Staging, Marts).
    - Thực hiện các lệnh biến đổi dữ liệu trực tiếp trong kho dữ liệu (In-warehouse transformation).
    - Kiểm thử dữ liệu (Data testing) và lập tài liệu tự động.
    - Đảm bảo tính nhất quán của dữ liệu qua các phiên bản.

### 🐝 Apache Hive
- **Vai trò**: Kho dữ liệu (Data Warehouse / Processing Engine).
- **Chức năng**:
    - Cung cấp giao diện truy vấn SQL (HiveQL) trên nền tảng dữ liệu lớn.
    - Chịu trách nhiệm thực thi các câu lệnh từ dbt gửi đến.
    - Quản lý cấu trúc bảng và lược đồ dữ liệu (Schema).

### 🐘 Apache Hadoop (HDFS)
- **Vai trò**: Tầng lưu trữ (Storage Layer).
- **Chức năng**:
    - Hệ thống tệp phân tán giúp lưu trữ các tệp dữ liệu thô và các bảng của Hive.
    - Đảm bảo khả năng mở rộng và chịu lỗi cho dữ liệu.

### 🐳 Docker & Docker Compose
- **Vai trò**: Quản lý hạ tầng (Infrastructure Management).
- **Chức năng**:
    - Đóng gói toàn bộ cụm Hadoop/Hive vào các container riêng biệt.
    - Đảm bảo môi trường chạy đồng nhất, dễ dàng thiết lập và gỡ bỏ mà không ảnh hưởng đến hệ điều hành gốc.

### 🐘 PostgreSQL
- **Vai trò**: Lưu trữ siêu dữ liệu (Metastore Database).
- **Chức năng**:
    - Lưu trữ thông tin về cấu trúc bảng, cột, kiểu dữ liệu của Hive.
    - Đóng vai trò là "bộ não" giúp Hive biết dữ liệu nằm ở đâu trong HDFS.

### 🐍 Python & Virtual Environment (venv)
- **Vai trò**: Môi trường thực thi (Execution Runtime).
- **Chức năng**:
    - Cung cấp môi trường sạch để cài đặt dbt và các thư viện cần thiết (`dbt-spark`, `PyHive`).
    - Giúp quản lý các phụ thuộc (dependencies) một cách độc lập.

### 🔌 Thrift Protocol
- **Vai trò**: Giao thức kết nối (Communication Protocol).
- **Chức năng**:
    - Cho phép dbt (chạy trên máy host) giao tiếp và gửi lệnh SQL tới HiveServer2 (chạy trong Docker container).

---

## 3. Luồng hoạt động (Workflow)

1.  **Dữ liệu thô (Raw Data)**: Được nạp vào HDFS dưới dạng các bảng Hive.
2.  **dbt Connect**: dbt sử dụng `profiles.yml` để kết nối tới Hive qua Thrift.
3.  **Transformation**: 
    - dbt gửi mã SQL đến Hive.
    - Hive thực thi truy vấn và lưu kết quả lại vào HDFS dưới dạng các View hoặc Table mới.
4.  **Validation**: dbt thực hiện các bài kiểm tra (Tests) để đảm bảo chất lượng dữ liệu cuối cùng.
5.  **Analytics**: Dữ liệu tại lớp `fct_revenue` đã sẵn sàng để đưa vào các công cụ BI (như Power BI, Tableau) hoặc báo cáo.
