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
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
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
    <title>User Profile | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .profile-container {
            padding-top: calc(var(--header-height) + 50px);
            padding-bottom: 100px;
            max-width: 800px;
            margin: 0 auto;
        }
        .profile-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            padding: 40px;
            border: 1px solid var(--gray-medium);
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 1px solid var(--gray-medium);
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            background: var(--gray-light);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: var(--accent-color);
        }
        .profile-title h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary-color);
        }
        .profile-title p {
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        .form-group {
            margin-bottom: 25px;
        }
        .form-group label {
            display: block;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            color: var(--secondary-color);
        }
        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--gray-medium);
            border-radius: 6px;
            font-family: inherit;
            font-size: 1rem;
            transition: all 0.3s;
        }
        .form-group input:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(44, 82, 130, 0.1);
        }
        .form-group input[readonly] {
            background-color: var(--gray-light);
            cursor: not-allowed;
            color: var(--text-muted);
        }
        .btn-save {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 15px 30px;
            font-size: 0.9rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 20px;
        }
        .btn-save:hover {
            background: #1e3a5f;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(44, 82, 130, 0.2);
        }
        .alert {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 30px;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-success {
            background-color: #f0fff4;
            color: #2f855a;
            border: 1px solid #c6f6d5;
        }
        .alert-error {
            background-color: #fff5f5;
            color: #c53030;
            border: 1px solid #fed7d7;
        }
        @media (max-width: 600px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            .profile-card {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="logo"><a href="home.jsp">Chill Nest</a></div>
        <nav>
            <ul>
                <li><a href="home.jsp">HOME</a></li>
                <li><a href="#">COLLECTION</a></li>
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
            <div class="user-info" style="display: flex; align-items: center; gap: 15px;">
                <a href="ProfileController" style="color: #2c5282; text-decoration: none; display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-circle-user" style="font-size: 1.5rem;"></i>
                    <span style="font-weight: 600; font-size: 0.9rem;">Hi, <%= user.getFullName() %></span>
                </a>
                <a href="LogoutController" style="font-size: 0.8rem; color: #666; text-decoration: underline;">Logout</a>
            </div>
        </div>
    </header>

    <main class="container profile-container">
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div class="profile-title">
                    <h1>My Profile</h1>
                    <p>Manage your account settings and personal information</p>
                </div>
            </div>

            <% if (message != null) { %>
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <%= message %>
                </div>
            <% } %>

            <% if (error != null) { %>
                <div class="alert alert-error">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <%= error %>
                </div>
            <% } %>

            <form action="ProfileController" method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>Username</label>
                        <input type="text" value="<%= user.getUsername() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" value="<%= user.getEmail() %>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullName" value="<%= user.getFullName() %>" required>
                    </div>
                    <div class="form-group">
                        <label>Phone Number</label>
                        <input type="text" name="phone" value="<%= user.getPhone() != null ? user.getPhone() : "" %>" placeholder="Enter your phone number">
                    </div>
                </div>

                <div style="margin-top: 40px; padding-top: 30px; border-top: 1px solid var(--gray-medium);">
                    <h3 style="font-size: 1.1rem; margin-bottom: 20px; color: var(--primary-color);">Security</h3>
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Current Password</label>
                            <input type="password" name="currentPassword" placeholder="Enter current password to change">
                        </div>
                        <div class="form-group" style="grid-column: span 2; display: grid; grid-template-columns: 1fr 1fr; gap: 30px; margin-bottom: 0;">
                            <div class="form-group">
                                <label>New Password</label>
                                <input type="password" name="newPassword" placeholder="Minimum 6 characters">
                            </div>
                            <div class="form-group">
                                <label>Confirm New Password</label>
                                <input type="password" name="confirmPassword" placeholder="Re-type new password">
                            </div>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-save">Save Changes</button>
            </form>
        </div>
    </main>

    <script>
        document.querySelector('form').addEventListener('submit', function(e) {
            const newPass = document.querySelector('input[name="newPassword"]').value;
            const confirmPass = document.querySelector('input[name="confirmPassword"]').value;
            const currentPass = document.querySelector('input[name="currentPassword"]').value;

            if (currentPass && newPass) {
                if (newPass.length < 6) {
                    alert('New password must be at least 6 characters.');
                    e.preventDefault();
                    return;
                }
                if (newPass !== confirmPass) {
                    alert('New passwords do not match.');
                    e.preventDefault();
                    return;
                }
            } else if (currentPass || newPass || confirmPass) {
                // If any password field is touched, all must be filled (except maybe confirm if they haven't gotten there yet)
                if (!currentPass || !newPass || !confirmPass) {
                    alert('Please fill in all password fields to change your password.');
                    e.preventDefault();
                }
            }
        });
    </script>

    <footer>
        <div class="container">
            <div class="footer-main">
                <div class="footer-logo-section">
                    <div class="logo"><a href="home.jsp">Chill Nest</a></div>
                    <p>The art of creating quiet and luxurious living spaces.</p>
                </div>
                <div class="footer-col">
                    <h4>EXPLORE</h4>
                    <ul><li><a href="#">Living Room</a></li><li><a href="#">Bedroom</a></li></ul>
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
