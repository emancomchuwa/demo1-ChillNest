<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Model.User" %>
<%@ page import="Model.CartItem" %>
<%@ page import="java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    Double orderTotal = (Double) request.getAttribute("orderTotal");
    String customerName = (String) request.getAttribute("customerName");
    String customerPhone = (String) request.getAttribute("customerPhone");
    String customerAddress = (String) request.getAttribute("customerAddress");
    String paymentMethod = (String) request.getAttribute("paymentMethod");
    
    if (customerName == null) {
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
    <title>Order Success | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root {
            --success-primary: #10B981;
            --success-bg: #ECFDF5;
            --success-primary-dark: #047857;
            --success-text: #1E1B4B;
            --success-border: #E2E8F0;
            --font-family: 'Outfit', sans-serif;
        }

        body {
            font-family: var(--font-family);
            background-color: #FAFAFB;
            color: #334155;
        }

        .success-wrapper {
            max-width: 650px;
            margin: calc(var(--header-height) + 60px) auto 80px;
            padding: 0 20px;
        }

        .success-card {
            background: white;
            padding: 50px 40px;
            border-radius: 28px;
            border: 1px solid var(--success-border);
            box-shadow: 0 15px 40px rgba(0,0,0,0.03);
            text-align: center;
        }

        .icon-circle {
            width: 80px;
            height: 80px;
            background: var(--success-bg);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--success-primary);
            font-size: 2.5rem;
            margin: 0 auto 25px;
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.15);
        }

        .success-title {
            font-size: 1.8rem;
            font-weight: 800;
            color: var(--success-text);
            margin-bottom: 12px;
        }

        .success-subtitle {
            color: #64748B;
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 35px;
        }

        /* Order Info Receipt Block */
        .receipt-box {
            background: #F8FAFC;
            border: 2px dashed #E2E8F0;
            border-radius: 20px;
            padding: 30px;
            text-align: left;
            margin-bottom: 35px;
        }

        .receipt-header {
            font-size: 1rem;
            font-weight: 700;
            color: var(--success-text);
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 1px solid #E2E8F0;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .receipt-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 0.9rem;
            line-height: 1.4;
        }
        .receipt-label {
            color: #64748B;
            font-weight: 500;
            min-width: 140px;
        }
        .receipt-value {
            color: var(--success-text);
            font-weight: 600;
            text-align: right;
        }

        .receipt-total-row {
            margin-top: 18px;
            padding-top: 18px;
            border-top: 1px solid #E2E8F0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .receipt-total-label {
            font-weight: 700;
            font-size: 1.05rem;
            color: var(--success-text);
        }
        .receipt-total-val {
            font-weight: 800;
            font-size: 1.4rem;
            color: #7C4DFF;
        }

        /* Buttons layout */
        .success-buttons {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }
        .btn {
            padding: 15px;
            border-radius: 12px;
            font-size: 0.95rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-home {
            background: white;
            border: 2px solid var(--success-border);
            color: #475569;
        }
        .btn-home:hover {
            background: #F8FAFC;
            border-color: #CBD5E1;
            transform: translateY(-2px);
        }
        .btn-continue {
            background: #7C4DFF;
            color: white;
            border: 2px solid #7C4DFF;
            box-shadow: 0 8px 16px rgba(124, 77, 255, 0.15);
        }
        .btn-continue:hover {
            background: #6D3DFF;
            border-color: #6D3DFF;
            transform: translateY(-2px);
            box-shadow: 0 10px 22px rgba(124, 77, 255, 0.25);
        }

        @media (max-width: 480px) {
            .success-buttons {
                grid-template-columns: 1fr;
            }
            .success-card {
                padding: 30px 20px;
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
                </div>
            <% } %>
        </div>
    </header>

    <main class="success-wrapper">
        <div class="success-card">
            <div class="icon-circle">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            
            <h1 class="success-title">Order Placed Successfully!</h1>
            <p class="success-subtitle">Thank you for choosing Chill Nest. We've received your order and are preparing it for absolute delivery perfection.</p>
            
            <!-- Receipt Dashed Box -->
            <div class="receipt-box">
                <div class="receipt-header">Order Invoice Summary</div>
                
                <div class="receipt-row">
                    <span class="receipt-label">Customer Name:</span>
                    <span class="receipt-value"><%= customerName %></span>
                </div>
                <div class="receipt-row">
                    <span class="receipt-label">Phone Number:</span>
                    <span class="receipt-value"><%= customerPhone %></span>
                </div>
                <div class="receipt-row">
                    <span class="receipt-label">Shipping Address:</span>
                    <span class="receipt-value"><%= customerAddress %></span>
                </div>
                <div class="receipt-row">
                    <span class="receipt-label">Payment Method:</span>
                    <span class="receipt-value"><%= paymentMethod %></span>
                </div>
                <div class="receipt-row">
                    <span class="receipt-label">Shipping Cost:</span>
                    <span class="receipt-value" style="color: var(--success-primary); font-weight: 700;">FREE</span>
                </div>
                
                <div class="receipt-total-row">
                    <span class="receipt-total-label">Grand Total:</span>
                    <span class="receipt-total-val"><%= String.format("%,.0fđ", orderTotal).replace(',', '.') %></span>
                </div>
            </div>
            
            <!-- Action buttons -->
            <div class="success-buttons">
                <a href="home.jsp" class="btn btn-home">
                    <i class="fa-solid fa-house"></i> Home Page
                </a>
                <a href="search" class="btn btn-continue">
                    <i class="fa-solid fa-bag-shopping"></i> Shop Collections
                </a>
            </div>
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
</body>
</html>
