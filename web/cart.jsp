<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
    double total = 0;
    int cartCount = 0;
    if (cart != null) {
        for (CartItem item : cart) {
            total += item.getSubtotal();
            cartCount += item.getQuantity();
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --cart-primary: #7C4DFF;
            --cart-secondary: #F3EEFF;
            --cart-dark: #1E1B4B;
            --cart-border: #E2E8F0;
            --font-family: 'Outfit', sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: #FAFAFB;
            color: #334155;
        }

        .cart-wrapper {
            max-width: 1200px;
            margin: calc(var(--header-height) + 50px) auto 80px;
            padding: 0 20px;
        }

        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--cart-dark);
            margin-bottom: 30px;
        }

        /* Empty state */
        .empty-cart-state {
            background: white;
            text-align: center;
            padding: 60px 40px;
            border-radius: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
            border: 1px solid var(--cart-border);
            max-width: 600px;
            margin: 40px auto;
        }
        .empty-cart-state i {
            font-size: 4.5rem;
            color: #CBD5E1;
            margin-bottom: 25px;
        }
        .empty-cart-state h3 {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--cart-dark);
            margin-bottom: 12px;
        }
        .empty-cart-state p {
            color: #64748B;
            margin-bottom: 30px;
            font-size: 0.95rem;
        }

        /* Columns Grid layout */
        .cart-grid {
            display: grid;
            grid-template-columns: 1fr 380px;
            gap: 35px;
            align-items: start;
        }

        /* Left column - items table container */
        .items-container {
            background: white;
            border-radius: 24px;
            border: 1px solid var(--cart-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
            overflow: hidden;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th {
            background: #F8FAFC;
            padding: 18px 24px;
            text-align: left;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: #64748B;
            font-weight: 600;
            border-bottom: 1px solid var(--cart-border);
        }

        .cart-table td {
            padding: 24px;
            border-bottom: 1px solid var(--cart-border);
            vertical-align: middle;
        }
        .cart-table tr:last-child td {
            border-bottom: none;
        }

        .item-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .item-icon-box {
            width: 60px;
            height: 60px;
            background: #F1F5F9;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--cart-primary);
            font-size: 1.5rem;
            border: 1px solid var(--cart-border);
        }
        .item-details h4 {
            font-size: 1rem;
            font-weight: 600;
            color: var(--cart-dark);
            margin-bottom: 4px;
        }
        .item-details span {
            font-size: 0.8rem;
            color: #94A3B8;
            background: #F1F5F9;
            padding: 2px 8px;
            border-radius: 20px;
            font-weight: 500;
        }

        .item-price {
            font-weight: 600;
            color: var(--cart-dark);
        }

        /* Quantity controls */
        .qty-controls {
            display: flex;
            align-items: center;
            border: 1px solid var(--cart-border);
            border-radius: 8px;
            width: fit-content;
            overflow: hidden;
            background: white;
        }
        .qty-btn {
            background: transparent;
            border: none;
            width: 32px;
            height: 32px;
            cursor: pointer;
            font-size: 0.85rem;
            color: var(--cart-dark);
            transition: background 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover {
            background: #F8FAFC;
        }
        .qty-val {
            width: 35px;
            text-align: center;
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--cart-dark);
            border: none;
            border-left: 1px solid var(--cart-border);
            border-right: 1px solid var(--cart-border);
            outline: none;
        }

        .item-subtotal {
            font-weight: 700;
            color: var(--cart-primary);
        }

        .remove-btn {
            background: transparent;
            border: none;
            color: #EF4444;
            cursor: pointer;
            font-size: 1.1rem;
            transition: transform 0.2s;
            padding: 5px;
        }
        .remove-btn:hover {
            transform: scale(1.15);
        }

        /* Right column - Summary block */
        .summary-card {
            background: white;
            padding: 30px;
            border-radius: 24px;
            border: 1px solid var(--cart-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }

        .summary-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--cart-dark);
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--cart-border);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 0.95rem;
            color: #64748B;
        }
        .summary-row.total-row {
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid var(--cart-border);
            color: var(--cart-dark);
            font-size: 1.2rem;
            font-weight: 700;
        }

        .btn-checkout {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            background: var(--cart-primary);
            color: white;
            border: none;
            padding: 16px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            margin-top: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(124, 77, 255, 0.2);
            text-decoration: none;
        }
        .btn-checkout:hover {
            background: #6D3DFF;
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(124, 77, 255, 0.3);
        }

        .btn-continue {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            color: var(--cart-primary);
            font-size: 0.95rem;
            font-weight: 600;
            margin-top: 15px;
            transition: color 0.2s;
        }
        .btn-continue:hover {
            color: #6D3DFF;
        }

        @media (max-width: 968px) {
            .cart-grid {
                grid-template-columns: 1fr;
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

    <main class="cart-wrapper">
        <h1 class="page-title">Shopping Cart</h1>

        <% if (cart == null || cart.isEmpty()) { %>
            <div class="empty-cart-state">
                <i class="fa-solid fa-cart-flatbed-suitcase"></i>
                <h3>Your Cart is Empty</h3>
                <p>Looks like you haven't added any luxury pieces to your cart yet. Let's explore our unique collections!</p>
                <a href="search" class="shop-now-btn" style="padding: 12px 30px; font-size: 0.9rem;">Shop Collections</a>
            </div>
        <% } else { %>
            <div class="cart-grid">
                <!-- Left: Items list -->
                <div class="items-container">
                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (CartItem item : cart) { %>
                                <tr>
                                    <td>
                                        <div class="item-info">
                                            <div class="item-icon-box">
                                                <i class="fa-solid fa-couch"></i>
                                            </div>
                                            <div class="item-details">
                                                <h4><%= item.getName() %></h4>
                                                <span><%= item.getCategory() %></span>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="item-price"><%= item.getFormattedPrice() %></div>
                                    </td>
                                    <td>
                                        <div class="qty-controls">
                                            <button type="button" class="qty-btn" onclick="window.location.href='cart?action=update&id=<%= item.getProductId() %>&qty=<%= item.getQuantity() - 1 %>'"><i class="fa-solid fa-minus"></i></button>
                                            <input type="text" class="qty-val" value="<%= item.getQuantity() %>" readonly>
                                            <button type="button" class="qty-btn" onclick="window.location.href='cart?action=update&id=<%= item.getProductId() %>&qty=<%= item.getQuantity() + 1 %>'"><i class="fa-solid fa-plus"></i></button>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="item-subtotal"><%= item.getFormattedSubtotal() %></div>
                                    </td>
                                    <td>
                                        <button type="button" class="remove-btn" onclick="if(confirm('Remove this product?')) window.location.href='cart?action=remove&id=<%= item.getProductId() %>'" title="Remove product">
                                            <i class="fa-solid fa-trash-can"></i>
                                        </button>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Right: Summary totals card -->
                <div class="summary-card">
                    <h3 class="summary-title">Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span style="font-weight: 600; color: var(--cart-dark);"><%= String.format("%,.0fđ", total).replace(',', '.') %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span style="color: #10B981; font-weight: 600;">Free</span>
                    </div>
                    <div class="summary-row">
                        <span>Tax / VAT</span>
                        <span>Included</span>
                    </div>
                    
                    <div class="summary-row total-row">
                        <span>Total Price</span>
                        <span><%= String.format("%,.0fđ", total).replace(',', '.') %></span>
                    </div>

                    <a href="checkout" class="btn-checkout">
                        <i class="fa-solid fa-lock"></i> Proceed to Checkout
                    </a>
                    
                    <a href="search" class="btn-continue">
                        <i class="fa-solid fa-arrow-left"></i> Continue Shopping
                    </a>
                </div>
            </div>
        <% } %>
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
</body>
</html>
