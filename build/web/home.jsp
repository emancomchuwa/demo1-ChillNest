<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chill Nest | Nâng tầm không gian sống của bạn</title>
    <meta name="description" content="Khám phá bộ sưu tập decor tinh tế với sắc trắng và xanh, mang lại sự bình yên và sang trọng cho ngôi nhà của bạn.">
    <link rel="stylesheet" href="style.css">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">Chill Nest</div>
        <nav>
            <ul>
                <li><a href="#">BỘ SƯU TẬP</a></li>
                <li><a href="#">PHÒNG KHÁCH</a></li>
                <li><a href="#">PHÒNG NGỦ</a></li>
                <li><a href="#">GIỚI THIỆU</a></li>
                <li><a href="#">LIÊN HỆ</a></li>
            </ul>
        </nav>
        <div class="header-right">
            <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            <% if (user == null) { %>
                <a href="login.jsp" class="shop-now-btn">ĐĂNG NHẬP</a>
            <% } else { %>
                <div class="user-info" style="display: flex; align-items: center; gap: 15px;">
                    <span style="font-weight: 600; font-size: 0.9rem; color: #2c5282;">Chào, <%= user.getFullName() %></span>
                    <a href="LogoutController" style="font-size: 0.8rem; color: #666; text-decoration: underline;">Đăng xuất</a>
                </div>
            <% } %>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero" style="background-image: url('img/phongkhach1.png');">
        <div class="hero-content">
            <h1>Nâng tầm không gian sống của bạn</h1>
            <p>Khám phá bộ sưu tập decor tinh tế với sắc trắng và xanh, mang lại sự bình yên và sang trọng cho ngôi nhà của bạn.</p>

        </div>
    </section>

    <!-- Categories Section -->
    <main class="container">
        <section class="section">
            <div class="section-title-wrapper">
                <h2 class="section-title">Không Gian Của Bạn</h2>
                <div class="title-line"></div>
            </div>

            <div class="category-grid">
                <div class="category-item">
                    <img src="img/phong-khach-mau-do-19.jpg" alt="Phòng khách">
                    <div class="category-label">
                        <span>Ở đâu đó</span>
                        <h3>Phòng khách</h3>
                    </div>
                </div>
                <div class="category-item">
                    <img src="img/thiet-ke-phong-ngu-mau-do-19.jpg" alt="Phòng ngủ">
                    <div class="category-label">
                        <h3>Phòng ngủ</h3>
                    </div>
                </div>
                <div class="category-item">
                    <img src="img/phong-lam-viec-do-19.jpg" alt="Phòng làm việc">
                    <div class="category-label">
                        <h3>Phòng làm việc</h3>
                    </div>
                </div>
            </div>

            <div class="quote-section">
                <p>Sự kết hợp tinh tế giữa thủ công truyền thống và thiết kế hiện đại.</p>
            </div>
        </section>

        <!-- Products Section -->
        <section class="section">
            <div class="product-grid">
                <!-- Product 1 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1581783898377-1c85bf937427?auto=format&fit=crop&q=80&w=800" alt="Bình gốm xanh Azure">
                    </div>
                    <div class="product-info">
                        <h3>Bình gốm xanh Azure</h3>
                        <p>Bình gốm xanh nghệ thuật</p>
                        <div class="product-price">1.250.000 đ</div>
                    </div>
                </div>
                <!-- Product 2 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1534073828943-f801091bb18c?auto=format&fit=crop&q=80&w=800" alt="Đèn bàn Minimalist">
                    </div>
                    <div class="product-info">
                        <h3>Đèn bàn Minimalist</h3>
                        <p>Đèn bàn tối giản hiện đại</p>
                        <div class="product-price">2.400.000 đ</div>
                    </div>
                </div>
                <!-- Product 3 -->
                <div class="product-card">
                    <div class="product-image">
                        <img src="https://images.unsplash.com/photo-1584100936595-c0654b55a2e6?auto=format&fit=crop&q=80&w=800" alt="Gối tựa Navy Silk">
                    </div>
                    <div class="product-info">
                        <h3>Gối tựa Navy Silk</h3>
                        <p>Gối tựa màu xanh navy</p>
                        <div class="product-price">650.000 đ</div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section class="features-grid">
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fa-solid fa-award"></i>
                </div>
                <h4>Chất lượng cao</h4>
                <p>Mỗi sản phẩm đều được tuyển chọn kỹ lưỡng từ những chất liệu cao cấp nhất, đảm bảo độ bền và tính thẩm mỹ vượt thời gian.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fa-solid fa-compass-drafting"></i>
                </div>
                <h4>Thiết kế độc bản</h4>
                <p>Bộ sưu tập mang đậm dấu ấn nghệ thuật riêng biệt, không hòa lẫn, kiến tạo không gian sống có chiều sâu và cá tính.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">
                    <i class="fa-solid fa-headset"></i>
                </div>
                <h4>Tư vấn chuyên nghiệp</h4>
                <p>Đội ngũ kiến trúc sư giàu kinh nghiệm sẵn sàng hỗ trợ bạn biến ý tưởng thành hiện thực với giải pháp tối ưu nhất.</p>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="footer-main">
                <div class="footer-logo-section">
                    <div class="logo">Chill Nest</div>
                    <p>Nghệ thuật kiến tạo không gian sống tĩnh lặng và sang trọng.</p>
                </div>
                <div class="footer-col">
                    <h4>KHÁM PHÁ</h4>
                    <ul>
                        <li><a href="#">Phòng Khách</a></li>
                        <li><a href="#">Phòng Ngủ</a></li>
                        <li><a href="#">Nhà Bếp / Tap Ăn</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>HỖ TRỢ</h4>
                    <ul>
                        <li><a href="#">Chính sách bảo mật</a></li>
                        <li><a href="#">Điều khoản dịch vụ</a></li>
                        <li><a href="#">Giao hàng & Đổi trả</a></li>
                    </ul>
                </div>
                <div class="footer-col">
                    <h4>MẠNG XÃ HỘI</h4>
                    <ul>
                        <li><a href="#">Instagram</a></li>
                        <li><a href="#">Pinterest</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Chill Nest Interior Arts. Tất cả quyền được bảo lưu.</p>
            </div>
        </div>
    </footer>

    <!-- Fixed Registration Button / User Button -->
    <button class="uiverse-button fixed-bottom-left" onclick="toggleUserMenu(event)">
        <svg class="sparkle" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path class="path" d="M12 2L14.7106 9.21058H21.8421L16.2658 13.7894L18.9764 21L12 16.4211L5.02361 21L7.73419 13.7894L2.15789 9.21058H9.28939L12 2Z" fill="currentColor"></path>
            <path class="path" d="M5.5 2L6.17764 3.80264H7.96053L6.56645 4.94736L7.24409 6.75L5.5 5.60528L3.75591 6.75L4.43355 4.94736L3.03947 3.80264H4.82236L5.5 2Z" fill="currentColor"></path>
            <path class="path" d="M18.5 4L19.1776 5.80264H20.9605L19.5664 6.94736L20.2441 8.75L18.5 7.60528L16.7559 8.75L17.4336 6.94736L16.0395 5.80264H17.8224L18.5 4Z" fill="currentColor"></path>
        </svg>
        <span class="text_button"><%= (user == null) ? "Đăng ký" : user.getUsername() %></span>
        <div class="dots_border"></div>
    </button>

    <script>
        // Toggle User Menu
        function toggleUserMenu(event) {
            <% if (user != null) { %>
                // Empty for now as user requested to delete menu content
            <% } else { %>
                window.location.href = 'register.jsp';
            <% } %>
        }

        // Smooth scroll header effect
        window.addEventListener('scroll', function() {
            const header = document.querySelector('header');
            if (window.scrollY > 50) {
                header.style.padding = '0 30px';
                header.style.boxShadow = '0 5px 20px rgba(0,0,0,0.1)';
            } else {
                header.style.padding = '0 50px';
                header.style.boxShadow = 'none';
            }
        });
    </script>
</body>
</html>
