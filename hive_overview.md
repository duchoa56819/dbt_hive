# Tổng quan về Apache Hive

## 1. Tại sao lại dùng Hive?

Apache Hive là một hệ thống kho dữ liệu (Data Warehouse) được xây dựng trên nền tảng **Hadoop**. Nó cho phép người dùng đọc, viết và quản lý các tập dữ liệu cực lớn (Petabytes) đang lưu trữ trong hệ thống tệp phân tán (như HDFS hoặc S3) bằng cách sử dụng **SQL**.

Hive ra đời để mang sức mạnh của SQL vào thế giới Big Data, giúp các nhà phân tích dữ liệu không cần biết lập trình Java/Python vẫn có thể khai thác dữ liệu trên Hadoop.

---

## 2. Hive ra đời nhằm giải quyết vấn đề gì?

Trước khi có Hive (khoảng năm 2007-2008), cách duy nhất để xử lý dữ liệu trên Hadoop là viết các chương trình **MapReduce**.

*   **Sự phức tạp của MapReduce:** Viết một câu lệnh kết nối (JOIN) hai bảng bằng MapReduce yêu cầu hàng trăm dòng mã Java phức tạp, khó viết và khó bảo trì.
*   **Rào cản kỹ thuật:** Chỉ những lập trình viên giỏi mới có thể làm việc với Hadoop. Các Data Analyst biết SQL gần như bị "bỏ rơi" trong kỷ nguyên Big Data đời đầu.
*   **Thiếu cấu trúc:** Dữ liệu trên HDFS thường là các file phẳng (flat files). Hive cung cấp một lớp **Metastore** để định nghĩa cấu trúc (bảng, cột, kiểu dữ liệu) cho các file này.

**Hive giải quyết bằng cách:**
*   Cung cấp ngôn ngữ **HiveQL** (tương tự SQL) để tự động chuyển đổi các câu lệnh SQL thành các job MapReduce (hoặc Tez/Spark) chạy trên cụm Hadoop.

---

## 3. Ưu và nhược điểm của Hive

### Ưu điểm
*   **Khả năng mở rộng (Scalability):** Có thể xử lý dữ liệu ở quy mô Petabytes bằng cách tận dụng hàng nghìn máy tính trong cụm Hadoop.
*   **Dễ sử dụng:** Giao diện SQL quen thuộc với đại đa số người làm dữ liệu.
*   **Hỗ trợ nhiều định dạng file:** Làm việc tốt với Parquet, ORC, Avro, Textfile, v.v.
*   **Chi phí thấp:** Chạy trên phần cứng phổ thông (commodity hardware), mã nguồn mở hoàn toàn.
*   **Metadata tập trung:** Hive Metastore đã trở thành tiêu chuẩn chung cho nhiều công cụ khác (như Spark, Presto, Trino) cùng sử dụng để hiểu cấu trúc dữ liệu.

### Nhược điểm
*   **Độ trễ cao (High Latency):** Hive không được thiết kế cho các truy vấn thời gian thực (real-time). Ngay cả một truy vấn đơn giản cũng mất vài giây đến vài chục giây để khởi tạo.
*   **Không hỗ trợ tốt cho giao dịch (OLTP):** Mặc dù các phiên bản mới có hỗ trợ ACID, nhưng Hive vẫn chủ yếu dành cho phân tích (OLAP), không dùng làm database cho ứng dụng web.
*   **Phụ thuộc vào Hadoop:** Việc cài đặt và vận hành Hive khá phức tạp vì nó kéo theo cả một hệ sinh thái Hadoop (HDFS, YARN, Zookeeper).

---

## 4. So sánh Hive với các công cụ khác

| Đặc điểm | Apache Hive | Traditional RDBMS (Oracle/MySQL) | Apache Spark SQL | Presto / Trino |
| :--- | :--- | :--- | :--- | :--- |
| **Dung lượng dữ liệu** | Rất lớn (Petabytes) | Vừa và nhỏ (Terabytes) | Rất lớn | Rất lớn |
| **Tốc độ truy vấn** | Chậm (Batch processing) | Rất nhanh | Nhanh (In-memory) | Rất nhanh (MPP) |
| **Chi phí** | Rẻ (Mã nguồn mở) | Đắt (License/Hardware) | Trung bình | Trung bình |
| **Mục đích chính** | Báo cáo định kỳ (Batch) | Ứng dụng/Giao dịch | Xử lý & ETL phức tạp | Truy vấn tương tác (Ad-hoc) |
| **Kiến trúc** | Schema-on-read | Schema-on-write | Cả hai | Schema-on-read |

### Khi nào chọn cái nào?
*   **Chọn Hive:** Khi bạn cần xử lý khối lượng dữ liệu khổng lồ theo lịch trình (ví dụ: chốt số cuối ngày) và ưu tiên tính ổn định hơn là tốc độ tức thời.
*   **Chọn RDBMS:** Khi bạn cần xây dựng ứng dụng web, cần tính nhất quán dữ liệu cực cao và dung lượng không quá lớn.
*   **Chọn Spark SQL:** Khi bạn cần xử lý dữ liệu nhanh (trong bộ nhớ) và có các logic biến đổi phức tạp kết hợp với Machine Learning.
*   **Chọn Presto/Trino:** Khi bạn cần truy vấn dữ liệu Big Data với tốc độ nhanh để làm Dashboard hoặc phân tích ngẫu hứng (Ad-hoc query).
