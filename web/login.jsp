<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; margin: 0; font-family: 'Inter', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .login-wrapper { display: flex; width: 100%; max-width: 1000px; height: 650px; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 50px rgba(0,0,0,0.1); margin: 20px; }
        .login-sidebar { flex: 1; background: linear-gradient(rgba(0, 86, 210, 0.7), rgba(0, 86, 210, 0.7)), url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&q=80&w=1000'); background-size: cover; background-position: center; padding: 50px; display: flex; flex-direction: column; justify-content: flex-end; color: white; position: relative; }
        .login-sidebar h2 { font-size: 3rem; line-height: 1.1; font-weight: 800; margin-bottom: 20px; letter-spacing: -1px; }
        .login-sidebar p { font-size: 1.1rem; opacity: 0.9; line-height: 1.6; max-width: 400px; }
        .login-form-container { flex: 1; padding: 60px; display: flex; flex-direction: column; justify-content: center; background: white; }
        .login-header h1 { font-size: 1.8rem; font-weight: 700; margin-bottom: 8px; color: #111; }
        .login-header p { color: #666; font-size: 0.9rem; margin-bottom: 30px; }
        .social-login { display: flex; gap: 15px; margin-bottom: 25px; }
        .social-btn { flex: 1; display: flex; align-items: center; justify-content: center; gap: 10px; padding: 12px; border: 1px solid #eee; border-radius: 10px; background: white; font-size: 0.9rem; font-weight: 600; cursor: pointer; }
        .divider { display: flex; align-items: center; margin-bottom: 25px; color: #999; font-size: 0.7rem; font-weight: 700; letter-spacing: 1px; }
        .divider::before, .divider::after { content: ""; flex: 1; height: 1px; background: #eee; }
        .divider span { padding: 0 15px; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-size: 0.8rem; font-weight: 700; margin-bottom: 8px; color: #333; }
        .form-group input { width: 100%; padding: 12px 15px; border: 1px solid #eee; border-radius: 8px; background: #fcfcfc; font-size: 0.9rem; box-sizing: border-box; }
        .form-options { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; font-size: 0.8rem; }
        .forgot-link { color: #0056d2; text-decoration: none; font-weight: 600; }
        .login-btn { width: 100%; padding: 15px; background: #004dc0; color: white; border: none; border-radius: 8px; font-size: 1rem; font-weight: 700; cursor: pointer; margin-bottom: 30px; }
        .footer-text { text-align: center; font-size: 0.85rem; color: #666; }
        .footer-text a { color: #0056d2; text-decoration: none; font-weight: 700; }
        @media (max-width: 900px) { .login-sidebar { display: none; } .login-wrapper { max-width: 500px; height: auto; } }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <div class="login-sidebar">
            <h2>Architecting the Future of Interior Art.</h2>
            <p>Join the leading platform for home decor and premium furniture.</p>
        </div>
        <div class="login-form-container">
            <div class="login-header">
                <h1>Welcome Back</h1>
                <p>Login to manage your Chill Nest account.</p>
                <% String success = request.getParameter("success"); if("true".equals(success)) { %>
                    <div style="color: #059669; background: #ecfdf5; padding: 10px; border-radius: 8px; font-size: 0.85rem; margin-bottom: 20px; border: 1px solid #6ee7b7;">
                        <i class="fa-solid fa-circle-check"></i> Registration successful! Please login.
                    </div>
                <% } %>
                <% String resetSuccess = request.getParameter("resetSuccess"); if("true".equals(resetSuccess)) { %>
                    <div style="color: #059669; background: #ecfdf5; padding: 10px; border-radius: 8px; font-size: 0.85rem; margin-bottom: 20px; border: 1px solid #6ee7b7;">
                        <i class="fa-solid fa-circle-check"></i> Password reset successful! Please login with your new password.
                    </div>
                <% } %>
                <% String error = (String) request.getAttribute("error"); if (error != null) { %>
                    <div style="color: #dc2626; background: #fef2f2; padding: 10px; border-radius: 8px; font-size: 0.85rem; margin-bottom: 20px; border: 1px solid #fca5a5;">
                        <i class="fa-solid fa-circle-exclamation"></i> <%= error %>
                    </div>
                <% } %>
            </div>
            <div class="social-login">
                <button class="social-btn" onclick="location.href='https://accounts.google.com/'"><img src="https://www.svgrepo.com/show/355037/google.svg" width="18" alt=""> Google</button>
                <button class="social-btn" onclick="location.href='https://www.facebook.com/'"><i class="fa-brands fa-facebook" style="font-size: 1.2rem; color: #1877F2;"></i> Facebook</button>
            </div>
            <div class="divider"><span>OR EMAIL</span></div>
            <form action="LoginController" method="POST">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="name@company.com" required>
                </div>
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between;"><label>Password</label><a href="forgotpassword.jsp" class="forgot-link">Forgot Password?</a></div>
                    <input type="password" name="password" placeholder="••••••••" required>
                </div>
                <div class="form-options">
                    <label style="display: flex; align-items: center; gap: 8px; font-weight: 500; color: #666;"><input type="checkbox"> Keep me logged in for 30 days</label>
                </div>
                <button type="submit" class="login-btn">Login to Chill Nest</button>
            </form>
            <p class="footer-text">New to Chill Nest? <a href="register.jsp">Create an account</a></p>
        </div>
    </div>
</body>
</html>
