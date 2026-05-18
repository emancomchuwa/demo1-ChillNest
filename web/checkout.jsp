<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
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
    <title>Checkout | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --chk-primary: #7C4DFF;
            --chk-secondary: #F3EEFF;
            --chk-dark: #1E1B4B;
            --chk-border: #E2E8F0;
            --font-family: 'Outfit', sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: #FAFAFB;
            color: #334155;
        }

        .chk-wrapper {
            max-width: 1200px;
            margin: calc(var(--header-height) + 50px) auto 80px;
            padding: 0 20px;
        }

        .page-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--chk-dark);
            margin-bottom: 30px;
        }

        /* 2 Columns Grid */
        .chk-grid {
            display: grid;
            grid-template-columns: 1fr 450px;
            gap: 40px;
            align-items: start;
        }

        /* Left: Form Card */
        .form-card {
            background: white;
            padding: 40px;
            border-radius: 24px;
            border: 1px solid var(--chk-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--chk-dark);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-title i {
            color: var(--chk-primary);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            color: #475569;
        }
        .form-group input, 
        .form-group textarea {
            width: 100%;
            padding: 14px 16px;
            border: 1px solid var(--chk-border);
            border-radius: 12px;
            font-family: inherit;
            font-size: 0.95rem;
            color: var(--chk-dark);
            transition: all 0.3s;
            background: #F8FAFC;
            box-sizing: border-box;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--chk-primary);
            box-shadow: 0 0 0 4px rgba(124, 77, 255, 0.1);
            background: white;
        }

        /* Payment Selector */
        .payment-options {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 15px;
        }
        .pay-option-card {
            border: 2px solid var(--chk-border);
            border-radius: 16px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            gap: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }
        .pay-option-card:hover {
            border-color: var(--chk-primary);
        }
        .pay-option-card input[type="radio"] {
            position: absolute;
            top: 20px;
            right: 20px;
            accent-color: var(--chk-primary);
            width: 18px;
            height: 18px;
        }
        .pay-icon {
            font-size: 1.8rem;
            color: var(--chk-primary);
        }
        .pay-title {
            font-weight: 700;
            color: var(--chk-dark);
            font-size: 0.95rem;
        }
        .pay-desc {
            font-size: 0.8rem;
            color: #64748B;
            line-height: 1.4;
        }

        /* Right: Order Summary */
        .summary-card {
            background: white;
            padding: 30px;
            border-radius: 24px;
            border: 1px solid var(--chk-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.02);
        }

        .summary-items-list {
            max-height: 250px;
            overflow-y: auto;
            margin-bottom: 25px;
            padding-right: 5px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #F1F5F9;
        }
        .summary-item:last-child {
            border-bottom: none;
        }
        .sum-details h5 {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--chk-dark);
            margin-bottom: 2px;
        }
        .sum-details span {
            font-size: 0.8rem;
            color: #94A3B8;
        }
        .sum-price {
            font-weight: 600;
            color: var(--chk-dark);
            font-size: 0.95rem;
        }

        .totals-block {
            border-top: 2px solid var(--chk-border);
            padding-top: 20px;
            margin-top: 10px;
        }
        .total-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.95rem;
            color: #64748B;
        }
        .total-row.grand-total {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid var(--chk-border);
            color: var(--chk-dark);
            font-size: 1.25rem;
            font-weight: 800;
        }

        .btn-order {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            width: 100%;
            background: var(--chk-primary);
            color: white;
            border: none;
            padding: 18px;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            margin-top: 25px;
            transition: all 0.3s ease;
            box-shadow: 0 10px 20px rgba(124, 77, 255, 0.2);
        }
        .btn-order:hover {
            background: #6D3DFF;
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(124, 77, 255, 0.3);
        }

        @media (max-width: 968px) {
            .chk-grid {
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
            <div class="user-info" style="display: flex; align-items: center; gap: 15px;">
                <a href="ProfileController" style="color: #2c5282; text-decoration: none; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-circle-user" style="font-size: 1.5rem;"></i>
                    <span style="font-weight: 600; font-size: 0.9rem;">Hi, <%= user.getFullName() %></span>
                </a>
                <a href="LogoutController" style="font-size: 0.8rem; color: #666; text-decoration: underline;">Logout</a>
            </div>
        </div>
    </header>

    <main class="chk-wrapper">
        <h1 class="page-title">Checkout</h1>

        <form action="checkout" method="POST">
            <div class="chk-grid">
                <!-- Left Column - Shipping & Payment -->
                <div class="form-card">
                    <!-- Shipping Info -->
                    <div class="section-title">
                        <i class="fa-solid fa-truck-ramp-box"></i>
                        <span>Shipping Information</span>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label>Full Name</label>
                            <input type="text" name="fullName" value="<%= user.getFullName() %>" required placeholder="Enter full name">
                        </div>
                        <div class="form-group">
                            <label>Phone Number</label>
                            <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" required placeholder="Enter phone number">
                        </div>
                    </div>

                    <div class="form-group">
                        <label>Shipping Address</label>
                        <textarea name="address" rows="3" required placeholder="Enter complete home address, street, ward, city"></textarea>
                    </div>

                    <!-- Payment Info -->
                    <div class="section-title" style="margin-top: 40px;">
                        <i class="fa-solid fa-wallet"></i>
                        <span>Payment Method</span>
                    </div>

                    <div class="payment-options">
                        <label class="pay-option-card" id="card-cod">
                            <input type="radio" name="payment" value="Cash on Delivery" checked>
                            <div class="pay-icon"><i class="fa-solid fa-truck-moving"></i></div>
                            <div class="pay-title">Cash On Delivery</div>
                            <div class="pay-desc">Pay directly in cash when the delivery driver hands over the items.</div>
                        </label>
                        <label class="pay-option-card" id="card-bank">
                            <input type="radio" name="payment" value="Bank Transfer">
                            <div class="pay-icon"><i class="fa-solid fa-building-columns"></i></div>
                            <div class="pay-title">Bank Transfer</div>
                            <div class="pay-desc">Transfer to our business bank account. Items will ship post confirmation.</div>
                        </label>
                    </div>
                </div>

                <!-- Right Column - Order Summary -->
                <div class="summary-card">
                    <h3 class="summary-title">Your Order</h3>

                    <div class="summary-items-list">
                        <% if (cart != null) {
                            for (CartItem item : cart) { %>
                                <div class="summary-item">
                                    <div class="sum-details">
                                        <h5><%= item.getName() %></h5>
                                        <span>Qty: <%= item.getQuantity() %> | <%= item.getMaterial() %></span>
                                    </div>
                                    <div class="sum-price"><%= item.getFormattedSubtotal() %></div>
                                </div>
                            <% }
                        } %>
                    </div>

                    <div class="totals-block">
                        <div class="total-row">
                            <span>Subtotal</span>
                            <span style="font-weight: 600; color: var(--chk-dark);"><%= String.format("%,.0fđ", total).replace(',', '.') %></span>
                        </div>
                        <div class="total-row">
                            <span>Shipping Costs</span>
                            <span style="color: #10B981; font-weight: 600;">Free</span>
                        </div>
                        <div class="total-row grand-total">
                            <span>Total Price</span>
                            <span><%= String.format("%,.0fđ", total).replace(',', '.') %></span>
                        </div>
                    </div>

                    <button type="submit" class="btn-order">
                        <i class="fa-solid fa-clipboard-check"></i> Place Your Order
                    </button>
                </div>
            </div>
        </form>
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
