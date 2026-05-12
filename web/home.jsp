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
    <title>Chill Nest | Elevate Your Living Space</title>
    <meta name="description" content="Discover an exquisite collection of decor with white and blue tones, bringing peace and luxury to your home.">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <header>
        <div class="logo">Chill Nest</div>
        <nav>
            <ul>
                <li><a href="#">COLLECTION</a></li>
                <li><a href="#">LIVING ROOM</a></li>
                <li><a href="#">BEDROOM</a></li>
                <li><a href="#">ABOUT US</a></li>
                <li><a href="#">CONTACT</a></li>
            </ul>
        </nav>
        <div class="header-right">
            <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
            <% if (user == null) { %>
                <a href="login.jsp" class="shop-now-btn">LOGIN</a>
            <% } else { %>
                <div class="user-info" style="display: flex; align-items: center; gap: 15px;">
                    <span style="font-weight: 600; font-size: 0.9rem; color: #2c5282;">Hi, <%= user.getFullName() %></span>
                    <a href="LogoutController" style="font-size: 0.8rem; color: #666; text-decoration: underline;">Logout</a>
                </div>
            <% } %>
        </div>
    </header>

    <section class="hero" style="background-image: url('img/phongkhach1.png');">
        <div class="hero-content">
            <h1>Elevate Your Living Space</h1>
            <p>Discover an exquisite collection of decor with white and blue tones, bringing peace and luxury to your home.</p>
        </div>
    </section>

    <main class="container">
        <section class="section">
            <div class="section-title-wrapper">
                <h2 class="section-title">Your Space</h2>
                <div class="title-line"></div>
            </div>
            <div class="category-grid">
                <div class="category-item">
                    <img src="img/phong-khach-mau-do-19.jpg" alt="Living Room">
                    <div class="category-label"><span>Somewhere</span><h3>Living Room</h3></div>
                </div>
                <div class="category-item">
                    <img src="img/thiet-ke-phong-ngu-mau-do-19.jpg" alt="Bedroom">
                    <div class="category-label"><h3>Bedroom</h3></div>
                </div>
                <div class="category-item">
                    <img src="img/phong-lam-viec-do-19.jpg" alt="Workplace">
                    <div class="category-label"><h3>Workplace</h3></div>
                </div>
            </div>
            <div class="quote-section">
                <p>A sophisticated blend of traditional craftsmanship and modern design.</p>
            </div>
        </section>

        <section class="section">
            <div class="product-grid">
                <div class="product-card">
                    <div class="product-image"><img src="https://images.unsplash.com/photo-1581783898377-1c85bf937427?auto=format&fit=crop&q=80&w=800" alt="Azure Ceramic Vase"></div>
                    <div class="product-info"><h3>Azure Ceramic Vase</h3><p>Artistic blue ceramic vase</p><div class="product-price">1,250,000 VND</div></div>
                </div>
                <div class="product-card">
                    <div class="product-image"><img src="https://images.unsplash.com/photo-1534073828943-f801091bb18c?auto=format&fit=crop&q=80&w=800" alt="Minimalist Lamp"></div>
                    <div class="product-info"><h3>Minimalist Lamp</h3><p>Modern minimalist desk lamp</p><div class="product-price">2,400,000 VND</div></div>
                </div>
                <div class="product-card">
                    <div class="product-image"><img src="https://images.unsplash.com/photo-1584100936595-c0654b55a2e6?auto=format&fit=crop&q=80&w=800" alt="Navy Silk Pillow"></div>
                    <div class="product-info"><h3>Navy Silk Pillow</h3><p>Navy blue silk pillow</p><div class="product-price">650,000 VND</div></div>
                </div>
            </div>
        </section>

        <section class="features-grid">
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-award"></i></div>
                <h4>High Quality</h4>
                <p>Each product is carefully selected from the highest quality materials, ensuring durability and timeless aesthetics.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-compass-drafting"></i></div>
                <h4>Unique Design</h4>
                <p>The collection carries a distinct artistic mark, creating a living space with depth and personality.</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-headset"></i></div>
                <h4>Professional Support</h4>
                <p>Our team of experienced architects is ready to help you turn your ideas into reality with the most optimal solutions.</p>
            </div>
        </section>
    </main>

    <footer>
        <div class="container">
            <div class="footer-main">
                <div class="footer-logo-section">
                    <div class="logo">Chill Nest</div>
                    <p>The art of creating quiet and luxurious living spaces.</p>
                </div>
                <div class="footer-col">
                    <h4>EXPLORE</h4>
                    <ul><li><a href="#">Living Room</a></li><li><a href="#">Bedroom</a></li><li><a href="#">Kitchen / Dining</a></li></ul>
                </div>
                <div class="footer-col">
                    <h4>SUPPORT</h4>
                    <ul><li><a href="#">Privacy Policy</a></li><li><a href="#">Terms of Service</a></li><li><a href="#">Shipping & Returns</a></li></ul>
                </div>
                <div class="footer-col">
                    <h4>SOCIAL MEDIA</h4>
                    <ul><li><a href="#">Instagram</a></li><li><a href="#">Pinterest</a></li></ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Chill Nest Interior Arts. All rights reserved.</p>
            </div>
        </div>
    </footer>


    <script>
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
