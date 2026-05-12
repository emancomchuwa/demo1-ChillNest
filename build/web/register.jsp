<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Account | Chill Nest</title>
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
        /* Left Sidebar (Content) */
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

        /* Right Form */
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
            <h2>Architecture of <span>Great Design.</span></h2>
            <p class="desc">Join the most refined interior network. Build your story in a space designed for clarity and prestige.</p>
            
            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-pen-to-square"></i></div>
                <div class="feature-text">
                    <h4>Premium Furniture</h4>
                    <p>Meticulously curated furniture for professional spaces.</p>
                </div>
            </div>

            <div class="feature-item">
                <div class="feature-icon"><i class="fa-solid fa-chart-line"></i></div>
                <div class="feature-text">
                    <h4>Deep Insights</h4>
                    <p>In-depth analytics for every space you create.</p>
                </div>
            </div>

            <div class="sidebar-img">
                <img src="https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?auto=format&fit=crop&q=80&w=800" alt="">
                <div class="img-label">Designed with purpose. Decorated with power.</div>
            </div>
        </div>

        <div class="register-form-container">
            <div class="form-header">
                <h1>Create Account</h1>
                <p>Start your journey with Chill Nest today.</p>
                
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
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Choose a unique username" required>
                </div>

                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Enter your full name" required>
                </div>

                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="name@company.com" required>
                </div>

                <div class="form-row">
                    <div class="form-group" style="flex:1">
                        <label>Password</label>
                        <input type="password" name="password" placeholder="••••••••" required>
                    </div>
                    <div class="form-group" style="flex:1">
                        <label>Confirm Password</label>
                        <input type="password" name="confirm" placeholder="••••••••" required>
                    </div>
                </div>

                <div class="terms">
                    <input type="checkbox" required>
                    <span>I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>.</span>
                </div>

                <button type="submit" class="register-btn">Create Account</button>
            </form>

            <p class="login-link">Already have an account? <a href="login.jsp">Login here</a></p>
        </div>
    </div>
</body>
</html>
