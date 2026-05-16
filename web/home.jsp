<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Dal.ProductDAO" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
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
            <form action="search" method="get" class="search-bar" style="display: flex; align-items: center; border: 1px solid #e2e8f0; border-radius: 20px; overflow: hidden; background: #fff; min-width: 250px;">
                <input type="text" name="query" placeholder="Search products..." style="border: none; padding: 8px 15px; outline: none; flex-grow: 1; font-size: 0.85rem; width: 100%;">
                <button type="submit" style="border: none; background: transparent; padding: 8px 15px; cursor: pointer; color: #2c5282;"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>
            <% if (user == null) { %>
                <a href="login.jsp" class="shop-now-btn">LOGIN</a>
            <% } else { %>
                <div class="user-info" style="display: flex; align-items: center; gap: 15px;">
                    <a href="ProfileController" style="color: #2c5282; text-decoration: none; display: flex; align-items: center; gap: 8px;">
                        <i class="fa-solid fa-circle-user" style="font-size: 1.5rem;"></i>
                        <span style="font-weight: 600; font-size: 0.9rem;">Hi, <%= user.getFullName() %></span>
                    </a>
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
            <div class="section-title-wrapper" style="justify-content: space-between;">
                <div style="display: flex; align-items: center; gap: 20px; flex-grow: 1;">
                    <h2 class="section-title">Featured Products</h2>
                    <div class="title-line"></div>
                </div>
                <form action="search" method="get" class="search-bar" style="display: flex; align-items: center; border: 1px solid #e2e8f0; border-radius: 20px; overflow: hidden; background: #fff; margin-left: 20px; min-width: 250px;">
                    <input type="text" name="query" placeholder="Search products..." style="border: none; padding: 10px 15px; outline: none; flex-grow: 1; font-size: 0.9rem; width: 100%;">
                    <button type="submit" style="border: none; background: transparent; padding: 10px 15px; cursor: pointer; color: #2c5282;"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>
            </div>
            <div class="product-grid">
                <%
                    int homePageNum = 1;
                    String pStr = request.getParameter("page");
                    if (pStr != null && !pStr.isEmpty()) {
                        try {
                            homePageNum = Integer.parseInt(pStr);
                        } catch (Exception e) {}
                    }
                    ProductDAO dao = new ProductDAO();
                    int homePageSize = 9;
                    int hTotalProducts = dao.getTotalProducts();
                    int hTotalPages = (int) Math.ceil((double) hTotalProducts / homePageSize);
                    List<Product> homeProducts = dao.getProductsByPage(homePageNum, homePageSize);
                    
                    for (Product p : homeProducts) {
                %>
                <div class="product-card">
                    <div class="product-image">
                        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                        <% } else { %>
                            <div style="width: 100%; height: 100%; background-color: #f4f4f4; display: flex; align-items: center; justify-content: center; color: #ccc;">
                                <i class="fa-solid fa-couch" style="font-size: 3rem;"></i>
                            </div>
                        <% } %>
                    </div>
                    <div class="product-info">
                        <h3 style="font-size: 1.1rem; font-weight: 600; margin-bottom: 5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="<%= p.getName() %>"><%= p.getName() %></h3>
                        <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 10px;">Material: <%= p.getMaterial() %></p>
                        <div class="product-price"><%= p.getFormattedPrice() %></div>
                    </div>
                </div>
                <% } %>
            </div>

            <!-- Pagination Controls for Home Page -->
            <% if (hTotalPages > 1) { %>
            <div class="pagination" style="display: flex; justify-content: center; align-items: center; gap: 8px; margin-top: 40px; width: 100%;">
                <% if (homePageNum > 1) { %>
                <a href="home.jsp?page=<%= homePageNum - 1 %>" style="display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 8px; background: white; color: var(--text-main); text-decoration: none; border: 1px solid var(--gray-medium); transition: 0.2s;"><i class="fa-solid fa-chevron-left"></i></a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, homePageNum - 2);
                    int endPage = Math.min(hTotalPages, homePageNum + 2);
                    
                    if (startPage > 1) { 
                %>
                        <a href="home.jsp?page=1" style="display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 8px; background: white; color: var(--text-main); text-decoration: none; border: 1px solid var(--gray-medium); transition: 0.2s;">1</a>
                        <% if (startPage > 2) { %> <span style="color: var(--text-muted);">...</span> <% } %>
                <% 
                    }
                    
                    for (int i = startPage; i <= endPage; i++) { 
                %>
                    <a href="home.jsp?page=<%= i %>" style="display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 8px; text-decoration: none; transition: 0.2s; <%= (i == homePageNum) ? "background: var(--accent-color); color: white; border: 1px solid var(--accent-color);" : "background: white; color: var(--text-main); border: 1px solid var(--gray-medium);" %>"><%= i %></a>
                <% 
                    }
                    
                    if (endPage < hTotalPages) { 
                %>
                        <% if (endPage < hTotalPages - 1) { %> <span style="color: var(--text-muted);">...</span> <% } %>
                        <a href="home.jsp?page=<%= hTotalPages %>" style="display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 8px; background: white; color: var(--text-main); text-decoration: none; border: 1px solid var(--gray-medium); transition: 0.2s;"><%= hTotalPages %></a>
                <% } %>
                
                <% if (homePageNum < hTotalPages) { %>
                <a href="home.jsp?page=<%= homePageNum + 1 %>" style="display: flex; align-items: center; justify-content: center; width: 40px; height: 40px; border-radius: 8px; background: white; color: var(--text-main); text-decoration: none; border: 1px solid var(--gray-medium); transition: 0.2s;"><i class="fa-solid fa-chevron-right"></i></a>
                <% } %>
            </div>
            <% } %>
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
