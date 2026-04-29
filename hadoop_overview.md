# Tổng quan về Apache Hadoop

## 1. Tại sao lại dùng Hadoop?

Apache Hadoop là một framework mã nguồn mở cho phép lưu trữ và xử lý dữ liệu cực lớn (Big Data) theo mô hình phân tán. Thay vì cố gắng mua một chiếc siêu máy tính cực đắt tiền, Hadoop cho phép bạn kết nối hàng nghìn máy tính rẻ tiền (commodity hardware) lại với nhau để tạo thành một hệ thống có sức mạnh khủng khiếp.

Hadoop là "nền móng" của hầu hết các kiến trúc Big Data hiện đại. Nếu không có Hadoop, việc lưu trữ và tính toán trên hàng trăm Terabytes hay Petabytes dữ liệu sẽ là một nhiệm vụ bất khả thi về mặt chi phí.

---

## 2. Hadoop ra đời nhằm giải quyết vấn đề gì?

Đầu những năm 2000, các công ty như Google và Yahoo đối mặt với sự bùng nổ dữ liệu web mà các hệ thống truyền thống không thể gánh vác nổi:

*   **Giới hạn lưu trữ:** Các ổ cứng đơn lẻ không đủ sức chứa toàn bộ dữ liệu web. Việc mở rộng theo chiều dọc (Vertical Scaling - mua máy to hơn) có chi phí tăng theo cấp số nhân và luôn có giới hạn vật lý.
*   **Tốc độ xử lý:** Việc đọc một file dữ liệu 100TB từ một ổ cứng duy nhất có thể mất hàng tuần.
*   **Rủi ro mất dữ liệu:** Trong một cụm hàng nghìn máy tính, việc một vài máy bị hỏng mỗi ngày là chuyện bình thường. Các hệ thống cũ không có cơ chế tự phục hồi tốt khi phần cứng gặp sự cố.

**Hadoop giải quyết bằng 2 thành phần cốt lõi:**
*   **HDFS (Hadoop Distributed File System):** Chia nhỏ file lớn thành các block và lưu trữ bản sao (replication) trên nhiều máy khác nhau. Nếu một máy hỏng, dữ liệu vẫn an toàn ở máy khác.
*   **MapReduce:** Thay vì đưa dữ liệu đến máy tính, Hadoop đưa "thuật toán" đến nơi dữ liệu đang nằm (Data Locality). Việc tính toán được thực hiện song song trên hàng nghìn máy cùng lúc.

---

## 3. Ưu và nhược điểm của Hadoop

### Ưu điểm
*   **Khả năng mở rộng cực cao (Scalability):** Bạn có thể tăng dung lượng lưu trữ và sức mạnh tính toán chỉ bằng cách mua thêm các máy tính phổ thông và cắm vào cụm.
*   **Tiết kiệm chi phí:** Sử dụng phần cứng rẻ tiền thay vì các hệ thống lưu trữ chuyên dụng đắt đỏ (như SAN/NAS).
*   **Khả năng chịu lỗi (Fault Tolerance):** Tự động sao lưu dữ liệu và tự động chạy lại các tác vụ bị lỗi khi có máy tính trong cụm gặp sự cố.
*   **Linh hoạt:** Có thể lưu trữ mọi loại dữ liệu (có cấu trúc, bán cấu trúc, phi cấu trúc như video, hình ảnh, log file).

### Nhược điểm
*   **Độ phức tạp cao:** Việc vận hành một cụm Hadoop (HDFS, YARN, Zookeeper...) đòi hỏi đội ngũ kỹ sư có chuyên môn sâu.
*   **Không dành cho dữ liệu nhỏ:** Nếu dữ liệu của bạn chỉ vài GB hoặc vài TB, việc dùng Hadoop sẽ chậm hơn nhiều so với database truyền thống do chi phí quản lý mạng và phân tán.
*   **Vấn đề file nhỏ (Small File Problem):** Hadoop quản lý metadata trong bộ nhớ của NameNode. Nếu bạn có quá nhiều file nhỏ, NameNode sẽ bị quá tải.
*   **Đang bị cạnh tranh bởi Cloud:** Ngày nay, nhiều công ty chuyển sang dùng S3 (AWS) hoặc GCS (Google Cloud) thay cho HDFS vì sự tiện lợi và chi phí rẻ hơn khi không phải tự vận hành server.

---

## 4. So sánh Hadoop với các công cụ khác

| Đặc điểm | Apache Hadoop | Traditional RDBMS | Cloud Storage (S3/GCS) | NoSQL (MongoDB) |
| :--- | :--- | :--- | :--- | :--- |
| **Loại dữ liệu** | Mọi loại dữ liệu | Có cấu trúc (Structured) | Mọi loại dữ liệu | Bán cấu trúc (JSON/Document) |
| **Mở rộng** | Ngang (Horizontal) | Dọc (Vertical) | Vô hạn (Serverless) | Ngang |
| **Chi phí phần cứng** | Rẻ (Phổ thông) | Rắt đắt (Chuyên dụng) | Trả theo dung lượng | Trung bình |
| **Xử lý dữ liệu** | Batch (Hàng loạt) | Giao dịch (Interactive) | Chỉ lưu trữ (Cần engine khác) | Nhanh (Real-time) |
| **Tính nhất quán** | Cuối cùng (Eventual) | Tức thời (ACID) | Cuối cùng | Tùy cấu hình |

### Khi nào chọn cái nào?
*   **Chọn Hadoop:** Khi bạn muốn tự xây dựng hạ tầng Big Data tại chỗ (On-premise) để xử lý lượng dữ liệu khổng lồ với chi phí phần cứng tối ưu.
*   **Chọn RDBMS:** Khi dữ liệu nhỏ, cần tính chính xác tuyệt đối (như giao dịch ngân hàng).
*   **Chọn Cloud Storage:** Khi bạn muốn tập trung vào xử lý dữ liệu mà không muốn lo lắng về việc sửa server, thay ổ cứng.
*   **Chọn NoSQL:** Khi bạn cần ứng dụng có tốc độ phản hồi cực nhanh và dữ liệu thay đổi cấu trúc thường xuyên.
