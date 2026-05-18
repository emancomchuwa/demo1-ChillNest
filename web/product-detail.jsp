<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    Product p = (Product) request.getAttribute("product");
    if (p == null) {
        response.sendRedirect("search");
        return;
    }
    List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("cart");
    int cartCount = 0;
    if (sessionCart != null) {
        for (CartItem item : sessionCart) {
            cartCount += item.getQuantity();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= p.getName() %> | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --detail-primary: #7C4DFF;
            --detail-secondary: #F3EEFF;
            --detail-dark: #1E1B4B;
            --detail-gray: #F8FAFC;
            --detail-border: #E2E8F0;
            --font-family: 'Outfit', sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: #FAFAFB;
            color: #334155;
        }

        .detail-wrapper {
            max-width: 1200px;
            margin: calc(var(--header-height) + 50px) auto 80px;
            padding: 0 20px;
        }

        /* Breadcrumbs */
        .breadcrumbs {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: #64748B;
            margin-bottom: 30px;
        }
        .breadcrumbs a {
            color: #64748B;
            text-decoration: none;
            transition: color 0.2s;
        }
        .breadcrumbs a:hover {
            color: var(--detail-primary);
        }
        .breadcrumbs i {
            font-size: 0.75rem;
        }

        /* Detail Grid */
        .detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 50px;
            background: white;
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
            border: 1px solid var(--detail-border);
        }

        /* Left Side - Image Box */
        .image-container {
            position: relative;
            background: linear-gradient(135deg, #F8FAFC 0%, #F1F5F9 100%);
            border-radius: 18px;
            aspect-ratio: 1/1;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            border: 1px solid var(--detail-border);
        }
        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .image-container:hover img {
            transform: scale(1.05);
        }
        .placeholder-image-icon {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
            color: #94A3B8;
        }
        .placeholder-image-icon i {
            font-size: 5rem;
        }

        /* Absolute Badges */
        .badge-list {
            position: absolute;
            top: 20px;
            left: 20px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            z-index: 2;
        }
        .badge-item {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .badge-hot {
            background: #FF4757;
            color: white;
        }
        .badge-new {
            background: var(--detail-primary);
            color: white;
        }

        /* Right Side - Product Info */
        .info-container {
            display: flex;
            flex-direction: column;
        }
        .category-tag {
            align-self: flex-start;
            background: var(--detail-secondary);
            color: var(--detail-primary);
            padding: 6px 16px;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .product-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--detail-dark);
            line-height: 1.25;
            margin-bottom: 15px;
        }

        /* Rating & Reviews */
        .rating-wrapper {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 25px;
        }
        .stars {
            color: #FBBF24;
            display: flex;
            gap: 2px;
        }
        .rating-value {
            font-weight: 600;
            color: var(--detail-dark);
        }
        .reviews-count {
            color: #64748B;
            font-size: 0.9rem;
        }

        /* Price */
        .price-box {
            background: #F8FAFC;
            padding: 20px 25px;
            border-radius: 16px;
            margin-bottom: 30px;
            border: 1px solid var(--detail-border);
        }
        .price-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748B;
            margin-bottom: 5px;
        }
        .price-value {
            font-size: 2.4rem;
            font-weight: 800;
            color: var(--detail-primary);
        }

        /* Tech Details Specs List */
        .specs-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 35px;
            padding-bottom: 25px;
            border-bottom: 1px solid var(--detail-border);
        }
        .spec-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .spec-label {
            font-size: 0.8rem;
            text-transform: uppercase;
            color: #94A3B8;
            font-weight: 600;
        }
        .spec-value {
            font-size: 1rem;
            color: var(--detail-dark);
            font-weight: 500;
        }

        /* Purchase actions Box */
        .purchase-actions {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        .qty-title {
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 0.95rem;
        }
        .qty-selector {
            display: flex;
            align-items: center;
            border: 2px solid var(--detail-border);
            border-radius: 12px;
            width: fit-content;
            background: white;
            overflow: hidden;
        }
        .qty-btn {
            background: transparent;
            border: none;
            width: 45px;
            height: 45px;
            cursor: pointer;
            font-size: 1.1rem;
            color: var(--detail-dark);
            transition: background 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background: var(--detail-gray);
        }
        .qty-input {
            width: 50px;
            height: 45px;
            border: none;
            border-left: 2px solid var(--detail-border);
            border-right: 2px solid var(--detail-border);
            text-align: center;
            font-size: 1rem;
            font-weight: 600;
            color: var(--detail-dark);
            outline: none;
        }

        .buttons-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 10px;
        }
        .btn {
            padding: 16px 30px;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        .btn-add-cart {
            background: white;
            border: 2px solid var(--detail-primary);
            color: var(--detail-primary);
        }
        .btn-add-cart:hover {
            background: var(--detail-secondary);
            transform: translateY(-2px);
        }
        .btn-buy-now {
            background: var(--detail-primary);
            border: 2px solid var(--detail-primary);
            color: white;
            box-shadow: 0 10px 20px rgba(124, 77, 255, 0.2);
        }
        .btn-buy-now:hover {
            background: #6D3DFF;
            border-color: #6D3DFF;
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(124, 77, 255, 0.3);
        }

        /* Trust Points */
        .trust-points {
            display: flex;
            justify-content: space-between;
            margin-top: 35px;
            padding-top: 25px;
            border-top: 1px solid var(--detail-border);
        }
        .trust-item {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 0.85rem;
            color: #64748B;
            font-weight: 500;
        }
        .trust-item i {
            font-size: 1.1rem;
            color: var(--detail-primary);
        }

        /* Description tab block */
        .desc-tabs-container {
            margin-top: 40px;
            background: white;
            padding: 40px;
            border-radius: 24px;
            border: 1px solid var(--detail-border);
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.02);
        }
        .desc-tabs-header {
            border-bottom: 2px solid var(--detail-border);
            display: flex;
            gap: 30px;
            margin-bottom: 25px;
        }
        .tab-btn {
            background: transparent;
            border: none;
            padding: 12px 5px;
            font-size: 1.1rem;
            font-weight: 600;
            color: #94A3B8;
            cursor: pointer;
            position: relative;
        }
        .tab-btn.active {
            color: var(--detail-primary);
        }
        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--detail-primary);
        }
        .tab-content {
            line-height: 1.7;
            font-size: 1rem;
            color: #475569;
        }

        /* Alert notifications */
        .cart-toast {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background: #10B981;
            color: white;
            padding: 15px 25px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(16, 185, 129, 0.3);
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 600;
            z-index: 9999;
            transform: translateY(100px);
            opacity: 0;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .cart-toast.show {
            transform: translateY(0);
            opacity: 1;
        }

        @media (max-width: 768px) {
            .detail-grid {
                grid-template-columns: 1fr;
                gap: 30px;
                padding: 20px;
            }
            .product-title {
                font-size: 1.8rem;
            }
            .buttons-group {
                grid-template-columns: 1fr;
            }
            .trust-points {
                flex-direction: column;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <!-- HEADER -->
    <header>
        <div class="logo"><a href="home.jsp">Chill Nest</a></div>
        <nav>
            <ul>
                <li><a href="home.jsp">HOME</a></li>
                <li><a href="search">COLLECTION</a></li>
                <li><a href="#">ABOUT US</a></li>
            </ul>
        </nav>
        <div class="header-right">
            <div style="margin-right: 15px; position: relative;">
                <a href="cart" class="header-cart-wrapper" style="color: #2c5282; font-size: 1.3rem; text-decoration: none;" title="View Cart">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <% if (cartCount > 0) { %>
                        <span class="header-cart-badge"><%= cartCount %></span>
                    <% } %>
                </a>
            </div>
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

    <main class="detail-wrapper">
        <!-- Breadcrumbs -->
        <div class="breadcrumbs">
            <a href="home.jsp">Home</a>
            <i class="fa-solid fa-chevron-right"></i>
            <a href="search">Products</a>
            <i class="fa-solid fa-chevron-right"></i>
            <a href="search?query=<%= p.getCategory() %>"><%= p.getCategory() %></a>
            <i class="fa-solid fa-chevron-right"></i>
            <span><%= p.getName() %></span>
        </div>

        <!-- Detail Layout Box -->
        <div class="detail-grid">
            <!-- Left image block -->
            <div class="image-container">
                <div class="badge-list">
                    <% if (p.isIsHot()) { %>
                        <span class="badge-item badge-hot"><i class="fa-solid fa-fire"></i> HOT</span>
                    <% } %>
                    <% if (p.isIsNew()) { %>
                        <span class="badge-item badge-new"><i class="fa-solid fa-bolt"></i> NEW</span>
                    <% } %>
                </div>

                <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                    <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                <% } else { %>
                    <div class="placeholder-image-icon">
                        <i class="fa-solid fa-couch"></i>
                        <span style="font-weight: 500; font-size: 0.95rem;">Premium Product Image</span>
                    </div>
                <% } %>
            </div>

            <!-- Right info block -->
            <div class="info-container">
                <span class="category-tag"><%= p.getCategory() %></span>
                <h1 class="product-title"><%= p.getName() %></h1>

                <!-- Rating -->
                <div class="rating-wrapper">
                    <div class="stars">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                    </div>
                    <span class="rating-value"><%= p.getRating() %></span>
                    <span class="reviews-count">(<%= p.getReviewCount() %> verified reviews)</span>
                </div>

                <!-- Price Box -->
                <div class="price-box">
                    <div class="price-label">Price</div>
                    <div class="price-value"><%= p.getFormattedPrice() %></div>
                </div>

                <!-- Specs List -->
                <div class="specs-grid">
                    <div class="spec-item">
                        <span class="spec-label">Material</span>
                        <span class="spec-value"><%= p.getMaterial() %></span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Primary Room</span>
                        <span class="spec-value"><%= p.getRoom() %></span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Availability</span>
                        <span class="spec-value" style="color: #10B981; font-weight: 600;">In Stock</span>
                    </div>
                    <div class="spec-item">
                        <span class="spec-label">Brand</span>
                        <span class="spec-value">Chill Nest Luxury</span>
                    </div>
                </div>

                <!-- Quantities & Buy Actions -->
                <div class="purchase-actions">
                    <div>
                        <div class="qty-title">Select Quantity</div>
                        <div class="qty-selector">
                            <button type="button" class="qty-btn" id="qty-minus"><i class="fa-solid fa-minus"></i></button>
                            <input type="text" id="qty-input" class="qty-input" value="1" readonly>
                            <button type="button" class="qty-btn" id="qty-plus"><i class="fa-solid fa-plus"></i></button>
                        </div>
                    </div>

                    <div class="buttons-group">
                        <button type="button" class="btn btn-add-cart" id="btn-add-cart">
                            <i class="fa-solid fa-cart-plus"></i> Add to Cart
                        </button>
                        <button type="button" class="btn btn-buy-now" id="btn-buy-now">
                            <i class="fa-solid fa-bag-shopping"></i> Buy Now
                        </button>
                    </div>
                </div>

                <!-- Trust Points badge -->
                <div class="trust-points">
                    <div class="trust-item">
                        <i class="fa-solid fa-truck-fast"></i>
                        <span>Free Shipping</span>
                    </div>
                    <div class="trust-item">
                        <i class="fa-solid fa-shield-halved"></i>
                        <span>3-Year Warranty</span>
                    </div>
                    <div class="trust-item">
                        <i class="fa-solid fa-arrow-rotate-left"></i>
                        <span>30 Days Return</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab description section -->
        <div class="desc-tabs-container">
            <div class="desc-tabs-header">
                <button type="button" class="tab-btn active">Product Description</button>
                <button type="button" class="tab-btn">Specifications</button>
            </div>
            <div class="tab-content">
                <p>Enhance the elegance of your room layout with this premium item from Chill Nest's exclusive signature collection. Designed with perfect visual proportion and structural perfection, it acts as a primary architectural anchor to your luxury residential space. Made of carefully sourced, eco-friendly materials that ensure supreme durability while maximizing comfort and aesthetic brilliance.</p>
                <p style="margin-top: 15px;">Whether you're looking to furnish a complete modern apartment,カフェ spaces, or creating a high-concept private studio setup, this versatile design matches flawlessly with Scandinavian, Japandi, and contemporary luxury design styles.</p>
            </div>
        </div>
    </main>

    <!-- Toast Notification -->
    <div class="cart-toast" id="cart-toast">
        <i class="fa-solid fa-circle-check" style="font-size: 1.3rem;"></i>
        <span id="toast-message">Product added to cart successfully!</span>
    </div>

    <!-- FOOTER -->
    <footer>
        <div class="container">
            <div class="footer-main">
                <div class="footer-logo-section">
                    <div class="logo"><a href="home.jsp">Chill Nest</a></div>
                    <p>The art of creating quiet and luxurious living spaces.</p>
                </div>
                <div class="footer-col">
                    <h4>EXPLORE</h4>
                    <ul><li><a href="search">Living Room</a></li><li><a href="search">Bedroom</a></li></ul>
                </div>
                <div class="footer-col">
                    <h4>SUPPORT</h4>
                    <ul><li><a href="#">Privacy Policy</a></li><li><a href="#">Terms of Service</a></li></ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2024 Chill Nest Interior Arts. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="chat-widget.js"></script>
    <script>
        // Quantity selectors triggers
        const qtyInput = document.getElementById('qty-input');
        const btnMinus = document.getElementById('qty-minus');
        const btnPlus  = document.getElementById('qty-plus');

        btnMinus.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            if (current > 1) {
                qtyInput.value = current - 1;
            }
        });

        btnPlus.addEventListener('click', () => {
            let current = parseInt(qtyInput.value);
            qtyInput.value = current + 1;
        });

        // Add to Cart ajax-like simulation or redirection
        const btnAddCart = document.getElementById('btn-add-cart');
        const btnBuyNow  = document.getElementById('btn-buy-now');
        const toast      = document.getElementById('cart-toast');
        const toastMsg   = document.getElementById('toast-message');

        function showToast(message) {
            toastMsg.innerText = message;
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }

        function addToCart(productId, qty, redirect) {
            // Redirect to CartController with add action
            window.location.href = 'cart?action=add&id=' + productId + '&qty=' + qty + (redirect ? '&redirect=checkout' : '');
        }

        btnAddCart.addEventListener('click', () => {
            addToCart(<%= p.getId() %>, qtyInput.value, false);
        });

        btnBuyNow.addEventListener('click', () => {
            addToCart(<%= p.getId() %>, qtyInput.value, true);
        });
    </script>
</body>
</html>
