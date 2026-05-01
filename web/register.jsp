<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tạo tài khoản | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background-color: #f8fafc;
            margin: 0;
            font-family: 'Inter', sans-serif;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .register-wrapper {
            display: flex;
            width: 100%;
            max-width: 1100px;
            height: 750px;
            background: white;
            border-radius: 30px;
            overflow: hidden;
            box-shadow: 0 25px 60px rgba(0,0,0,0.08);
            margin: 20px;
        }
        /* Sidebar Trái (Content) */
        .register-sidebar {
            flex: 1.1;
            padding: 60px;
            display: flex;
            flex-direction: column;
            background: #fff;
            position: relative;
        }
        .register-sidebar h2 {
            font-size: 3.5rem;
            font-weight: 800;
            color: #111;
            margin-bottom: 20px;
            line-height: 1.1;
        }
        .register-sidebar h2 span {
            color: #0056d2;
        }
        .register-sidebar .desc {
            color: #666;
            font-size: 1.1rem;
            line-height: 1.6;
            margin-bottom: 40px;
            max-width: 450px;
        }
        .feature-item {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            align-items: flex-start;
        }
        .feature-icon {
            width: 40px;
            height: 40px;
            background: #f1f5f9;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0056d2;
            flex-shrink: 0;
        }
        .feature-text h4 {
            margin: 0 0 5px 0;
            font-size: 1.1rem;
            font-weight: 700;
        }
        .feature-text p {
            margin: 0;
            font-size: 0.9rem;
            color: #777;
        }
        .sidebar-img {
            margin-top: auto;
            border-radius: 15px;
            overflow: hidden;
            height: 180px;
            background: linear-gradient(135deg, #e2e8f0, #cbd5e1);
            position: relative;
        }
        .sidebar-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            opacity: 0.6;
        }
        .sidebar-img .img-label {
            position: absolute;
            bottom: 20px;
            left: 20px;
            color: #333;
            font-size: 0.8rem;
            font-weight: 600;
        }

        /* Form Phải */
        .register-form-container {
            flex: 1;
            background: #fcfcfc;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            border-left: 1px solid #f1f5f9;
        }
        .form-header h1 {
            font-size: 2rem;
            font-weight: 800;
            margin: 0 0 10px 0;
        }
        .form-header p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 35px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .form-group input {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid #e2e8f0;
            border-radius: 10px;
            background: #fff;
            box-sizing: border-box;
            font-size: 0.9rem;
        }
        .form-row {
            display: flex;
            gap: 15px;
        }
        .terms {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.85rem;
            color: #666;
            margin-bottom: 30px;
        }
        .terms a {
            color: #0056d2;
            text-decoration: none;
            font-weight: 600;
        }
        .register-btn {
            width: 100%;
            padding: 16px;
            background: #0056d2;
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            margin-bottom: 30px;
        }
        .login-link {
            text-align: center;
            font-size: 0.9rem;
            color: #666;
        }
        .login-link a {
            color: #0056d2;
            text-decoration: none;
            font-weight: 700;
        }

        @media (max-width: 950px) {
            .register-sidebar { display: none; }
            .register-wrapper { max-width: 500px; height: auto; }
        }
    </style>
</head>
<body>
    <div class="register-wrapper">
        <div class="register-sidebar">
            <h2>Kiến trúc của <span>Thiết kế Tuyệt vời.</span></h2>
            <p class="desc">Gia nhập mạng lưới nội thất tinh tế nhất. Xây dựng câu chuyện của bạn trong một không gian được thiết kế cho sự rõ ràng và uy tín.</p>
            
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-pen-to-square"></i></div>
                <div class="feature-text">
                    <h4>Nội thất Cao cấp</h4>
                    <p>Nội thất được tuyển chọn kỹ lưỡng cho các không gian chuyên nghiệp.</p>
                </div>
            </div>

            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-chart-line"></i></div>
                <div class="feature-text">
                    <h4>Cái nhìn Sâu sắc</h4>
                    <p>Phân tích chuyên sâu cho mọi không gian bạn tạo ra.</p>
                </div>
            </div>

            <div class="sidebar-img">
                <img src="https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?auto=format&fit=crop&q=80&w=800" alt="">
                <div class="img-label">Thiết kế có chủ đích. Trang trí bằng quyền năng.</div>
            </div>
        </div>

        <div class="register-form-container">
            <div class="form-header">
                <h1>Tạo tài khoản</h1>
                <p>Bắt đầu hành trình của bạn với Chill Nest ngay hôm nay.</p>
                
                <%-- Display error message if exists --%>
                <% String error = (String) request.getAttribute("error"); %>
                <% if(error != null) { %>
                    <div style="color: #e11d48; background: #fff1f2; padding: 10px; border-radius: 8px; font-size: 0.85rem; margin-bottom: 20px; border: 1px solid #fda4af;">
                        <i class="fa-solid fa-circle-exclamation"></i> <%= error %>
                    </div>
                <% } %>
            </div>

            <form action="register" method="POST">
                <div class="form-group">
                    <label>Tên đăng nhập</label>
                    <input type="text" name="username" placeholder="Chọn một tên đăng nhập duy nhất" required>
                </div>

                <div class="form-group">
                    <label>Họ và tên</label>
                    <input type="text" name="name" placeholder="Nhập họ và tên của bạn" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ Email</label>
                    <input type="email" name="email" placeholder="name@company.com" required>
                </div>

                <div class="form-row">
                    <div class="form-group" style="flex:1">
                        <label>Mật khẩu</label>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                    <div class="form-group" style="flex:1">
                        <label>Xác nhận mật khẩu</label>
                        <input type="password" name="confirm" placeholder="••••••••" required>
                    </div>
                </div>

                <div class="terms">
                    <input type="checkbox" required>
                    <span>Tôi đồng ý với <a href="#">Điều khoản dịch vụ</a> và <a href="#">Chính sách bảo mật</a>.</span>
                </div>

                <button type="submit" class="register-btn">Tạo tài khoản</button>
            </form>

            <p class="login-link">Đã có tài khoản? <a href="login.jsp">Đăng nhập tại đây</a></p>
        </div>
    </div>
</body>
</html>
