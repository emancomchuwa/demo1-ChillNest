<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password | Chill Nest</title>
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
        .login-wrapper {
            display: flex;
            width: 100%;
            max-width: 1000px;
            height: 650px;
            background: white;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            margin: 20px;
        }
        /* Left Sidebar */
        .login-sidebar {
            flex: 1;
            background: linear-gradient(rgba(0, 86, 210, 0.75), rgba(0, 50, 160, 0.85)),
                        url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&q=80&w=1000');
            background-size: cover;
            background-position: center;
            padding: 50px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            color: white;
            position: relative;
        }
        .login-sidebar .icon-lock {
            position: absolute;
            top: 50px;
            left: 50px;
            font-size: 3rem;
            opacity: 0.3;
        }
        .login-sidebar h2 {
            font-size: 2.6rem;
            line-height: 1.2;
            font-weight: 800;
            margin-bottom: 16px;
            letter-spacing: -1px;
        }
        .login-sidebar p {
            font-size: 1rem;
            opacity: 0.85;
            line-height: 1.7;
            max-width: 360px;
        }
        /* Step indicator */
        .steps {
            display: flex;
            gap: 10px;
            margin-top: 40px;
        }
        .step {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.78rem;
            opacity: 0.6;
            font-weight: 600;
        }
        .step.active { opacity: 1; }
        .step-num {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            background: rgba(255,255,255,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
        }
        .step.active .step-num {
            background: white;
            color: #0056d2;
        }

        /* Right Form */
        .login-form-container {
            flex: 1;
            padding: 60px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: white;
        }
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.8rem;
            color: #666;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 30px;
            transition: color 0.2s;
        }
        .back-link:hover { color: #0056d2; }

        .login-header .icon-circle {
            width: 52px;
            height: 52px;
            background: #eff6ff;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            font-size: 1.4rem;
            color: #0056d2;
        }
        .login-header h1 {
            font-size: 1.7rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #111;
        }
        .login-header p {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }
        .input-wrapper {
            position: relative;
        }
        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 0.9rem;
        }
        .form-group input {
            width: 100%;
            padding: 13px 15px 13px 40px;
            border: 1.5px solid #eee;
            border-radius: 10px;
            background: #fcfcfc;
            font-size: 0.9rem;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }
        .form-group input:focus {
            border-color: #0056d2;
            box-shadow: 0 0 0 3px rgba(0, 86, 210, 0.08);
            background: white;
        }

        /* Alert messages */
        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-error {
            color: #dc2626;
            background: #fef2f2;
            border: 1px solid #fca5a5;
        }

        .submit-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #0056d2, #003fa0);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            margin-bottom: 25px;
            transition: opacity 0.2s, transform 0.1s;
            letter-spacing: 0.3px;
        }
        .submit-btn:hover { opacity: 0.92; transform: translateY(-1px); }
        .submit-btn:active { transform: translateY(0); }

        .footer-text {
            text-align: center;
            font-size: 0.85rem;
            color: #666;
        }
        .footer-text a {
            color: #0056d2;
            text-decoration: none;
            font-weight: 700;
        }

        @media (max-width: 900px) {
            .login-sidebar { display: none; }
            .login-wrapper { max-width: 500px; height: auto; }
        }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <!-- Left Sidebar -->
        <div class="login-sidebar">
            <i class="fa-solid fa-lock icon-lock"></i>
            <h2>Recover your account.</h2>
            <p>Enter your email address and we will send you an OTP to reset your password.</p>
            <div class="steps">
                <div class="step active">
                    <div class="step-num">1</div>
                    <span>Email Verification</span>
                </div>
                <div class="step">
                    <div class="step-num">2</div>
                    <span>New Password</span>
                </div>
            </div>
        </div>

        <!-- Right Form -->
        <div class="login-form-container">
            <a href="LoginController" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Back to Login
            </a>

            <div class="login-header">
                <div class="icon-circle">
                    <i class="fa-solid fa-envelope-open-text"></i>
                </div>
                <h1>Forgot Password?</h1>
                <p>No worries! Enter your registered email and we'll help you reset it.</p>

                <%-- Display error if exists --%>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <%= error %>
                    </div>
                <% } %>
            </div>

            <form action="ForgotPasswordController" method="POST">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope"></i>
                        <input type="email" id="email" name="email"
                               placeholder="Enter your registered email..."
                               value="<%= request.getAttribute("emailValue") != null ? request.getAttribute("emailValue") : "" %>"
                               required autofocus>
                    </div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fa-solid fa-magnifying-glass"></i>&nbsp; Verify Email
                </button>
            </form>

            <p class="footer-text">Remember your password? <a href="LoginController">Login now</a></p>
        </div>
    </div>
</body>
</html>
