<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    List<Model.Product> products = (List<Model.Product>) request.getAttribute("products");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages  = (Integer) request.getAttribute("totalPages");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    String query = (String) request.getAttribute("query");
    String room  = (String) request.getAttribute("room");

    if (products == null) {
        products = new java.util.ArrayList<>();
        currentPage   = 1;
        totalPages    = 1;
        totalProducts = 0;
        query = "";
    }
    if (room  == null) room  = "";
    if (query == null) query = "";

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
    <title>Search Products | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Specific Styles for Search Page */
        :root {
            --search-primary: #7C4DFF;
            --search-secondary: #F3EEFF;
            --search-bg: #FFFFFF;
            --search-text: #2B2B2B;
            --search-text-muted: #666666;
            --search-border: #E5E7EB;
        }

        body {
            background-color: #f8f9fa;
            color: var(--search-text);
        }

        .search-container {
            max-width: 1400px;
            margin: calc(var(--header-height) + 40px) auto 60px;
            padding: 0 20px;
            display: grid;
            grid-template-columns: 280px 1fr;
            gap: 30px;
        }

        /* Top Search Header Area */
        .search-header-top {
            grid-column: 1 / -1;
            margin-bottom: 20px;
        }
        
        .main-search-input-wrapper {
            display: flex;
            align-items: center;
            background: white;
            border: 2px solid var(--search-primary);
            border-radius: 30px;
            padding: 5px 20px;
            max-width: 800px;
            margin: 0 auto 30px;
            box-shadow: 0 10px 25px rgba(124, 77, 255, 0.1);
        }
        
        .main-search-input-wrapper input {
            border: none;
            outline: none;
            padding: 12px 0;
            font-size: 1.1rem;
            flex-grow: 1;
            color: var(--search-text);
        }
        
        .main-search-input-wrapper button {
            background: transparent;
            border: none;
            color: var(--search-primary);
            font-size: 1.2rem;
            cursor: pointer;
            padding: 10px;
        }
        
        .mic-btn {
            color: var(--search-text-muted);
        }

        .search-results-meta h1 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 5px;
        }
        
        .search-results-meta h1 span {
            color: var(--search-primary);
        }

        .search-results-meta p {
            color: var(--search-text-muted);
            font-size: 0.95rem;
        }



        /* Sidebar Filter */
        .filter-sidebar {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0,0,0,0.03);
            height: fit-content;
        }

        .filter-group {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid var(--search-border);
        }
        
        .filter-group:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .filter-title {
            font-weight: 600;
            font-size: 1.05rem;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            transition: color 0.2s;
        }

        .filter-title:hover {
            color: var(--search-primary);
        }

        .filter-list {
            list-style: none;
            padding: 0;
            animation: slideDown 0.3s ease forwards;
        }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .filter-list li {
            margin-bottom: 10px;
        }

        .filter-label {
            display: flex;
            align-items: center;
            cursor: pointer;
            font-size: 0.95rem;
            color: var(--search-text);
            transition: color 0.2s;
        }

        .filter-label:hover {
            color: var(--search-primary);
        }

        .filter-label input[type="checkbox"], 
        .filter-label input[type="radio"] {
            margin-right: 10px;
            accent-color: var(--search-primary);
            width: 16px;
            height: 16px;
            cursor: pointer;
        }

        /* Room filter links */
        .room-filter-list { list-style: none; padding: 0; }
        .room-link {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 6px 0;
            text-decoration: none;
            color: var(--search-text);
            font-size: 0.95rem;
            border-radius: 6px;
            transition: color 0.2s;
        }
        .room-link:hover { color: var(--search-primary); }
        .room-link.room-active {
            color: var(--search-primary);
            font-weight: 600;
        }
        .room-checkbox-icon { font-size: 1rem; color: #ccc; }
        .room-link.room-active .room-checkbox-icon { color: var(--search-primary); }
        .clear-room-filter {
            display: inline-block;
            margin-top: 8px;
            font-size: 0.82rem;
            color: #e53e3e;
            text-decoration: none;
            padding: 4px 10px;
            border: 1px solid #fed7d7;
            border-radius: 20px;
            background: #fff5f5;
            transition: all 0.2s;
        }
        .clear-room-filter:hover { background: #fed7d7; }


        .category-list a {
            display: block;
            padding: 8px 0;
            color: var(--search-text);
            transition: all 0.2s;
            text-decoration: none;
        }
        .category-list a:hover {
            color: var(--search-primary);
            padding-left: 5px;
        }

        /* Color filters */
        .color-filters {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }
        .color-dot {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: inline-block;
            cursor: pointer;
            border: 1px solid #ddd;
            position: relative;
            transition: transform 0.2s;
        }
        .color-dot:hover {
            transform: scale(1.1);
        }
        .color-dot.active::after {
            content: '\f00c';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 12px;
            color: white;
            text-shadow: 0 0 2px rgba(0,0,0,0.5);
        }

        /* Price Slider */
        .price-slider-container {
            margin-top: 15px;
        }
        .price-inputs {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-top: 15px;
        }
        .price-inputs input {
            width: 100%;
            padding: 8px;
            border: 1px solid var(--search-border);
            border-radius: 6px;
            font-size: 0.85rem;
            text-align: center;
            outline-color: var(--search-primary);
        }

        /* Product Grid */
        .search-results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 25px;
        }

        .s-product-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.04);
            transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
            position: relative;
            border: 1px solid transparent;
            cursor: pointer;
        }

        .s-product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(124, 77, 255, 0.15);
            border-color: var(--search-secondary);
        }

        .s-badge-hot {
            position: absolute;
            top: 15px;
            left: 15px;
            background: #FF4757;
            color: white;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            z-index: 2;
            display: flex;
            align-items: center;
            gap: 4px;
            box-shadow: 0 2px 5px rgba(255, 71, 87, 0.4);
        }

        .s-product-img {
            position: relative;
            aspect-ratio: 4/4;
            overflow: hidden;
            background: #f4f4f4;
        }

        .s-product-img img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s ease;
        }

        .s-product-card:hover .s-product-img img {
            transform: scale(1.08);
        }

        .s-product-info {
            padding: 20px;
        }

        .s-product-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--search-text);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            line-height: 1.4;
        }

        .s-product-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85rem;
            color: #FFA502;
            margin-bottom: 8px;
        }
        
        .s-product-rating span {
            color: var(--search-text-muted);
        }

        .s-product-meta {
            font-size: 0.85rem;
            color: var(--search-text-muted);
            margin-bottom: 12px;
        }

        .s-product-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
        }

        .s-product-price {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--search-primary);
        }

        .s-add-cart-btn {
            background: var(--search-secondary);
            color: var(--search-primary);
            border: none;
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            font-size: 1.1rem;
        }

        .s-add-cart-btn:hover {
            background: var(--search-primary);
            color: white;
            transform: scale(1.1) rotate(5deg);
            box-shadow: 0 4px 10px rgba(124, 77, 255, 0.3);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 40px;
        }
        .page-item {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 8px;
            background: white;
            color: var(--search-text);
            font-weight: 500;
            text-decoration: none;
            border: 1px solid var(--search-border);
            transition: all 0.2s;
        }
        .page-item:hover, .page-item.active {
            background: var(--search-primary);
            color: white;
            border-color: var(--search-primary);
        }

        /* Responsive */
        @media (max-width: 968px) {
            .search-container {
                grid-template-columns: 1fr;
            }
            .filter-sidebar {
                display: none; 
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
                <li><a href="#">COLLECTION</a></li>
                <li><a href="#">LIVING ROOM</a></li>
                <li><a href="#">BEDROOM</a></li>
                <li><a href="#">ABOUT US</a></li>
                <li><a href="#">CONTACT</a></li>
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
            <form action="search.jsp" method="get" class="search-bar" style="display: flex; align-items: center; border: 1px solid #e2e8f0; border-radius: 20px; overflow: hidden; background: #fff; min-width: 250px;">
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

    <main class="search-container">
        <!-- Top Area -->
        <div class="search-header-top">
            <form action="search" method="get" class="main-search-input-wrapper">
                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                <input type="text" name="query" value="<%= query %>" placeholder="Search for sofas, desks, lamps...">
                <button type="button" class="mic-btn"><i class="fa-solid fa-microphone"></i></button>
            </form>

            <div class="search-results-meta">
                <h1>Search Results: <span>“<%= query %>”</span></h1>
                <p><%= totalProducts %> products found</p>

            </div>
        </div>

        <!-- Sidebar Filters -->
        <aside class="filter-sidebar">
            <div class="filter-group">
                <div class="filter-title">Product Categories <i class="fa-solid fa-chevron-up"></i></div>
                <div class="category-list">
                    <a href="search?query=Sofa">Sofa</a>
                    <a href="search?query=Bed">Bed</a>
                    <a href="search?query=Tables %26 Chairs">Tables & Chairs</a>
                    <a href="search?query=Decor Lights">Decor Lights</a>
                    <a href="search?query=Bookshelves">Bookshelves</a>
                    <a href="search?query=Room Decor">Room Decor</a>
                    <a href="search?query=Artificial Plants">Artificial Plants</a>
                    <a href="search?query=Workspace Setup">Workspace Setup</a>
                    <a href="search?query=Kitchen Furniture">Kitchen Furniture</a>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-title">Space / Room <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list room-filter-list">
                    <% String[] roomOpts = {"Bedroom","Living Room","Workspace","Gaming Room","Studio","Mini Apartment","Cafe"};
                       for (String ro : roomOpts) {
                           boolean active = ro.equals(room); %>
                    <li>
                        <a href="search?query=<%= query %>&room=<%= active ? "" : java.net.URLEncoder.encode(ro, "UTF-8") %>"
                           class="filter-label room-link <%= active ? "room-active" : "" %>">
                            <span class="room-checkbox-icon"><i class="fa-solid <%= active ? "fa-square-check" : "fa-square" %>"></i></span>
                            <%= ro %>
                        </a>
                    </li>
                    <% } %>
                </ul>
                <% if (!room.isEmpty()) { %>
                <a href="search?query=<%= query %>" class="clear-room-filter">
                    <i class="fa-solid fa-xmark"></i> Clear room filter
                </a>
                <% } %>
            </div>
            
            <div class="filter-group">
                <div class="filter-title">Sort By <i class="fa-solid fa-chevron-up"></i></div>
                <select style="width: 100%; padding: 10px; border: 1px solid var(--search-border); border-radius: 6px; outline: none; font-family: inherit; font-size: 0.95rem; cursor: pointer;">
                    <option>Hottest 🔥</option>
                    <option>Newest ✨</option>
                    <option>Best Selling</option>
                    <option>Price: Low to High</option>
                    <option>Price: High to Low</option>
                    <option>Highest Rated</option>
                    <option>TikTok Trending</option>
                </select>
            </div>

            <div class="filter-group">
                <div class="filter-title">Price Range <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list">
                    <li><label class="filter-label"><input type="radio" name="price"> Under 500k</label></li>
                    <li><label class="filter-label"><input type="radio" name="price"> 500k - 1M</label></li>
                    <li><label class="filter-label"><input type="radio" name="price"> 1M - 3M</label></li>
                    <li><label class="filter-label"><input type="radio" name="price"> 3M - 5M</label></li>
                    <li><label class="filter-label"><input type="radio" name="price"> Over 5M</label></li>
                </ul>
                <div class="price-slider-container">
                    <p style="font-size: 0.85rem; color: var(--search-text-muted); text-align: center; margin: 10px 0;">Or</p>
                    <input type="range" min="0" max="10000000" style="width: 100%; accent-color: var(--search-primary);">
                    <div class="price-inputs">
                        <input type="text" placeholder="Min Price">
                        <span>-</span>
                        <input type="text" placeholder="Max Price">
                    </div>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-title">Material <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list">
                    <li><label class="filter-label"><input type="checkbox"> Natural Wood</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Industrial Wood</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Metal</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Tempered Glass</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Premium Plastic</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Felt Fabric</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Leather</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Rattan & Bamboo</label></li>
                </ul>
            </div>

            <div class="filter-group">
                <div class="filter-title">Color <i class="fa-solid fa-chevron-up"></i></div>
                <div class="color-filters">
                    <span class="color-dot" style="background-color: #ffffff;" title="White"></span>
                    <span class="color-dot" style="background-color: #000000;" title="Black"></span>
                    <span class="color-dot" style="background-color: #8B4513;" title="Brown"></span>
                    <span class="color-dot active" style="background-color: #7C4DFF;" title="Purple"></span>
                    <span class="color-dot" style="background-color: #4CAF50;" title="Green"></span>
                    <span class="color-dot" style="background-color: #2196F3;" title="Blue"></span>
                    <span class="color-dot" style="background-color: #9E9E9E;" title="Gray"></span>
                    <span class="color-dot" style="background-color: #F5F5DC;" title="Cream"></span>
                </div>
            </div>

            <div class="filter-group">
                <div class="filter-title">Design Style <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list">
                    <li><label class="filter-label"><input type="checkbox"> Minimalist</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Modern</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Luxury</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Korean Style</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Japandi</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Vintage</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Scandinavian</label></li>
                </ul>
            </div>

            <div class="filter-group">
                <div class="filter-title">Product Rating <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list">
                    <li><label class="filter-label"><input type="radio" name="rating"> <span style="color:#FFA502; margin-left: 5px;">⭐⭐⭐⭐⭐</span></label></li>
                    <li><label class="filter-label"><input type="radio" name="rating"> <span style="color:#FFA502; margin-left: 5px;">⭐⭐⭐⭐</span> <span style="margin-left: 5px;">& Up</span></label></li>
                    <li><label class="filter-label"><input type="radio" name="rating"> <span style="color:#FFA502; margin-left: 5px;">⭐⭐⭐</span> <span style="margin-left: 5px;">& Up</span></label></li>
                </ul>
            </div>

            <div class="filter-group">
                <div class="filter-title">Product Status <i class="fa-solid fa-chevron-up"></i></div>
                <ul class="filter-list">
                    <li><label class="filter-label"><input type="checkbox"> In Stock</label></li>
                    <li><label class="filter-label"><input type="checkbox"> On Sale</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Free Shipping</label></li>
                    <li><label class="filter-label"><input type="checkbox"> New Arrival</label></li>
                    <li><label class="filter-label"><input type="checkbox"> Best Seller</label></li>
                </ul>
            </div>
        </aside>

        <!-- Product Grid and Pagination -->
        <div style="display: flex; flex-direction: column;">
            <% if (products.isEmpty()) { %>
                <div style="grid-column: 1 / -1; padding: 60px 20px; text-align: center; background: white; border-radius: 12px; box-shadow: 0 2px 10px rgba(0,0,0,0.04);">
                    <i class="fa-solid fa-box-open" style="font-size: 4rem; color: #cbd5e1; margin-bottom: 20px;"></i>
                    <h3 style="font-size: 1.4rem; font-weight: 600; color: var(--search-text); margin-bottom: 10px;">Product Not Found</h3>
                    <p style="color: var(--search-text-muted); font-size: 1rem;">Sorry, we couldn't find any product matching the keyword "<strong><%= query %></strong>".</p>
                    <a href="search" style="display: inline-block; margin-top: 20px; padding: 10px 25px; background: var(--search-primary); color: white; border-radius: 30px; text-decoration: none; font-weight: 500; transition: 0.2s;">View All Products</a>
                </div>
            <% } else { %>
            <div class="search-results-grid">
                <% for (Model.Product p : products) { %>
                <div class="s-product-card" onclick="window.location.href='product-detail?id=<%= p.getId() %>'">
                    <% if (p.isIsHot()) { %>
                    <div class="s-badge-hot"><i class="fa-solid fa-fire"></i> HOT</div>
                    <% } else if (p.isIsNew()) { %>
                    <div class="s-badge-hot" style="background: var(--search-primary);"><i class="fa-solid fa-bolt"></i> NEW</div>
                    <% } %>
                    <div class="s-product-img">
                        <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
                            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
                        <% } else { %>
                            <div style="width: 100%; height: 100%; background-color: #f4f4f4; display: flex; align-items: center; justify-content: center; color: #ccc;">
                                <i class="fa-solid fa-couch" style="font-size: 3rem;"></i>
                            </div>
                        <% } %>
                    </div>
                    <div class="s-product-info">
                        <h3 class="s-product-title"><%= p.getName() %></h3>
                        <div class="s-product-rating">
                            <i class="fa-solid fa-star"></i> <%= p.getRating() %> <span>(<%= p.getReviewCount() %>)</span>
                        </div>
                        <div class="s-product-meta">
                            Material: <%= p.getMaterial() %>
                        </div>
                        <div class="s-product-bottom">
                            <div class="s-product-price"><%= p.getFormattedPrice() %></div>
                            <button class="s-add-cart-btn" title="Add to cart" onclick="event.stopPropagation(); window.location.href='cart?action=add&id=<%= p.getId() %>&qty=1'">
                                <i class="fa-solid fa-cart-plus"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>
            
            <!-- Pagination Controls -->
            <% if (totalPages > 1) { %>
            <div class="pagination">
                <% if (currentPage > 1) { %>
                <a href="search?query=<%= query %>&page=<%= currentPage - 1 %>" class="page-item"><i class="fa-solid fa-chevron-left"></i></a>
                <% } %>
                
                <% 
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage + 2);
                    
                    if (startPage > 1) { 
                %>
                        <a href="search?query=<%= query %>&page=1" class="page-item">1</a>
                        <% if (startPage > 2) { %> <span style="color: var(--search-text-muted);">...</span> <% } %>
                <% 
                    }
                    
                    for (int i = startPage; i <= endPage; i++) { 
                %>
                    <a href="search?query=<%= query %>&page=<%= i %>" class="page-item <%= (i == currentPage) ? "active" : "" %>"><%= i %></a>
                <% 
                    }
                    
                    if (endPage < totalPages) { 
                %>
                        <% if (endPage < totalPages - 1) { %> <span style="color: var(--search-text-muted);">...</span> <% } %>
                        <a href="search?query=<%= query %>&page=<%= totalPages %>" class="page-item"><%= totalPages %></a>
                <% } %>
                
                <% if (currentPage < totalPages) { %>
                <a href="search?query=<%= query %>&page=<%= currentPage + 1 %>" class="page-item"><i class="fa-solid fa-chevron-right"></i></a>
                <% } %>
            </div>
            <% } %>
        </div>
    </main>

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

    <script src="chat-widget.js"></script>
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
        
        // Filter collapse/expand toggle animation
        document.querySelectorAll('.filter-title').forEach(title => {
            title.addEventListener('click', () => {
                const icon = title.querySelector('i');
                icon.classList.toggle('fa-chevron-up');
                icon.classList.toggle('fa-chevron-down');
                
                const content = title.nextElementSibling;
                if (content.style.display === 'none' || content.style.opacity === '0') {
                    content.style.display = 'block';
                    setTimeout(() => {
                        content.style.opacity = '1';
                        content.style.animation = 'slideDown 0.3s ease forwards';
                    }, 10);
                } else {
                    content.style.animation = 'none';
                    content.style.opacity = '0';
                    setTimeout(() => {
                        content.style.display = 'none';
                    }, 200);
                }
            });
        });
    </script>
</body>
</html>
