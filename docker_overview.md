# Tổng quan về Docker & Docker Compose

## 1. Tại sao lại dùng Docker & Docker Compose?

Docker là một nền tảng cho phép bạn "đóng gói" ứng dụng cùng với toàn bộ môi trường của nó (thư viện, cấu hình, biến môi trường...) vào một đơn vị duy nhất gọi là **Container**. 

Docker Compose là công cụ đi kèm giúp bạn quản lý và chạy đồng thời nhiều Container cùng lúc chỉ bằng một file cấu hình duy nhất (`docker-compose.yml`). Thay vì phải khởi động từng dịch vụ một cách thủ công, bạn chỉ cần một câu lệnh để toàn bộ hệ thống (ví dụ: Hadoop + Hive + Postgres) tự động bật lên và kết nối với nhau.

---

## 2. Docker & Docker Compose ra đời nhằm giải quyết vấn đề gì?

Trước khi có Docker, giới lập trình thường xuyên gặp phải các vấn đề "kinh điển":

*   **"Nó chạy trên máy tôi mà!" (It works on my machine):** Ứng dụng chạy tốt trên máy của lập trình viên nhưng khi đưa lên máy đồng nghiệp hoặc server thì bị lỗi do khác biệt về phiên bản Java, Python, hoặc hệ điều hành.
*   **Cài đặt phức tạp:** Để cài đặt một cụm Hadoop/Hive thực tế, bạn có thể mất vài ngày để cấu hình hàng trăm file hệ thống. Với Docker, bạn chỉ cần tải "Image" đã được cấu hình sẵn về và chạy.
*   **Xung đột môi trường:** Làm sao để chạy hai ứng dụng trên cùng một máy khi một cái yêu cầu Python 2.7 và cái kia yêu cầu Python 3.10? Docker cô lập hoàn toàn môi trường của mỗi ứng dụng.
*   **Quản lý nhiều dịch vụ:** Một hệ thống hiện đại thường gồm nhiều phần (Web, DB, Cache, Worker). Việc quản lý việc khởi động, kết nối mạng giữa chúng một cách thủ công là cực hình. Docker Compose sinh ra để giải quyết việc này.

---

## 3. Ưu và nhược điểm của Docker & Docker Compose

### Ưu điểm
*   **Tính nhất quán:** Đảm bảo môi trường chạy giống hệt nhau từ máy cá nhân (Local) đến môi trường kiểm thử (Staging) và triển khai thực tế (Production).
*   **Tốc độ:** Khởi động Container chỉ mất vài giây, nhanh hơn rất nhiều so với khởi động Máy ảo (Virtual Machine).
*   **Tiết kiệm tài nguyên:** Container chia sẻ chung nhân (kernel) của hệ điều hành máy chủ, nên cực kỳ nhẹ và tốn ít RAM/CPU hơn Máy ảo.
*   **Cộng đồng khổng lồ (Docker Hub):** Có sẵn hàng triệu Image cho mọi phần mềm phổ biến (MySQL, Postgres, Hive, Spark...) giúp bạn thiết lập hạ tầng trong vài phút.
*   **Tự động hóa:** Rất dễ dàng tích hợp vào quy trình CI/CD để tự động build và deploy.

### Nhược điểm
*   **Hiệu năng trên Windows/Mac:** Docker chạy mượt nhất trên Linux. Trên Windows/Mac, nó phải chạy qua một lớp ảo hóa nhẹ (WSL2 hoặc VM), dẫn đến tiêu tốn một lượng tài nguyên nền nhất định.
*   **Dữ liệu tạm thời (Ephemeral):** Theo mặc định, dữ liệu trong Container sẽ mất sạch khi Container bị xóa. Bạn phải cấu hình "Volumes" một cách cẩn thận để lưu trữ dữ liệu bền vững.
*   **Bảo mật:** Mặc dù được cô lập, nhưng vì dùng chung nhân hệ điều hành, nếu nhân bị tấn công, các Container có thể bị ảnh hưởng (tuy nhiên rủi ro này rất thấp với người dùng thông thường).

---

## 4. So sánh Docker với các công cụ khác

| Đặc điểm | Docker Container | Virtual Machine (Máy ảo) | Bare Metal (Cài trực tiếp) | Kubernetes (K8s) |
| :--- | :--- | :--- | :--- | :--- |
| **Tốc độ khởi động** | Giây | Phút | Nhanh | Giây |
| **Sử dụng tài nguyên** | Thấp (Chia sẻ kernel) | Cao (Mỗi VM một OS riêng) | Tối ưu nhất | Thấp |
| **Tính cô lập** | Mức Process (Tiến trình) | Mức Hardware (Phần cứng) | Không cô lập | Mức Process |
| **Tính di động** | Rất cao | Trung bình | Thấp | Rất cao |
| **Mục đích chính** | Đóng gói & Phát triển | Giả lập hệ điều hành | Hiệu năng tối đa | Quản lý quy mô lớn (Scaling) |

### Khi nào chọn cái nào?
*   **Chọn Docker:** Khi bạn muốn phát triển ứng dụng một cách nhanh chóng, nhất quán và dễ dàng chia sẻ với người khác.
*   **Chọn Docker Compose:** Khi bạn muốn chạy một nhóm các Container có liên quan đến nhau trên một máy duy nhất (như dự án dbt + Hive này).
*   **Chọn Virtual Machine:** Khi bạn cần chạy một ứng dụng yêu cầu hệ điều hành hoàn toàn khác (ví dụ: chạy app Windows trên server Linux).
*   **Chọn Kubernetes:** Khi hệ thống của bạn quá lớn (hàng trăm container) và cần các tính năng tự động mở rộng (Auto-scaling), tự phục hồi (Self-healing) trên nhiều server.
