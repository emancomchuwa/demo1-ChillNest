<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password | Chill Nest</title>
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
            height: 680px;
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
        }
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
        .step.done { opacity: 0.8; }
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
        .step.done .step-num {
            background: rgba(255,255,255,0.5);
            color: white;
        }
        .step.active .step-num {
            background: white;
            color: #0056d2;
        }

        /* Right Form */
        .login-form-container {
            flex: 1;
            padding: 55px 60px;
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
            margin-bottom: 28px;
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
            margin-bottom: 6px;
            color: #111;
        }
        .email-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: #eff6ff;
            color: #0056d2;
            font-size: 0.82rem;
            font-weight: 600;
            padding: 5px 12px;
            border-radius: 20px;
            margin-bottom: 24px;
        }

        /* Alert */
        .alert {
            padding: 12px 15px;
            border-radius: 10px;
            font-size: 0.85rem;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .alert-error { color: #dc2626; background: #fef2f2; border: 1px solid #fca5a5; }

        .form-group { margin-bottom: 18px; }
        .form-group label {
            display: block;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: #333;
        }
        .input-wrapper { position: relative; }
        .input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            font-size: 0.9rem;
        }
        .input-wrapper .toggle-pw {
            left: auto;
            right: 14px;
            cursor: pointer;
            font-size: 0.85rem;
            color: #999;
            transition: color 0.2s;
        }
        .input-wrapper .toggle-pw:hover { color: #0056d2; }

        .form-group input {
            width: 100%;
            padding: 13px 42px 13px 40px;
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

        /* Password strength */
        .strength-bar {
            display: flex;
            gap: 4px;
            margin-top: 8px;
        }
        .strength-bar span {
            flex: 1;
            height: 4px;
            border-radius: 4px;
            background: #eee;
            transition: background 0.3s;
        }
        .strength-label {
            font-size: 0.75rem;
            margin-top: 5px;
            color: #999;
            font-weight: 600;
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
            margin-top: 8px;
            margin-bottom: 20px;
            transition: opacity 0.2s, transform 0.1s;
        }
        .submit-btn:hover { opacity: 0.92; transform: translateY(-1px); }
        .submit-btn:active { transform: translateY(0); }

        .footer-text {
            text-align: center;
            font-size: 0.85rem;
            color: #666;
        }
        .footer-text a { color: #0056d2; text-decoration: none; font-weight: 700; }

        @media (max-width: 900px) {
            .login-sidebar { display: none; }
            .login-wrapper { max-width: 500px; height: auto; }
        }
    </style>
</head>
<body>
<%
    // Page Protection: if no email in session, redirect to forgotpassword
    String resetEmail = (String) session.getAttribute("resetEmail");
    if (resetEmail == null || resetEmail.isEmpty()) {
        response.sendRedirect("forgotpassword.jsp");
        return;
    }
%>
    <div class="login-wrapper">
        <!-- Left Sidebar -->
        <div class="login-sidebar">
            <i class="fa-solid fa-key icon-lock"></i>
            <h2>Create a secure password.</h2>
            <p>Choose a strong password, at least 6 characters, including uppercase letters and numbers.</p>
            <div class="steps">
                <div class="step done">
                    <div class="step-num"><i class="fa-solid fa-check" style="font-size:0.6rem"></i></div>
                    <span>Email Verification</span>
                </div>
                <div class="step active">
                    <div class="step-num">2</div>
                    <span>New Password</span>
                </div>
            </div>
        </div>

        <!-- Right Form -->
        <div class="login-form-container">
            <a href="forgotpassword.jsp" class="back-link">
                <i class="fa-solid fa-arrow-left"></i> Back
            </a>

            <div class="login-header">
                <div class="icon-circle">
                    <i class="fa-solid fa-key"></i>
                </div>
                <h1>Reset Password</h1>
                <div class="email-badge">
                    <i class="fa-solid fa-envelope"></i>
                    <%= resetEmail %>
                </div>

                <%-- Display error if exists --%>
                <% String error = (String) request.getAttribute("error"); %>
                <% if (error != null) { %>
                    <div class="alert alert-error">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <%= error %>
                    </div>
                <% } %>
            </div>

            <form action="ResetPasswordController" method="POST">
                <div class="form-group">
                    <label for="newPassword">New Password</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="newPassword" name="newPassword"
                               placeholder="At least 6 characters..."
                               oninput="checkStrength(this.value)"
                               required autofocus>
                        <i class="fa-solid fa-eye toggle-pw" onclick="togglePw('newPassword', this)"></i>
                    </div>
                    <div class="strength-bar">
                        <span id="s1"></span>
                        <span id="s2"></span>
                        <span id="s3"></span>
                        <span id="s4"></span>
                    </div>
                    <div class="strength-label" id="strengthLabel">Enter password to check strength</div>
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-lock"></i>
                        <input type="password" id="confirmPassword" name="confirmPassword"
                               placeholder="Re-enter password..."
                               required>
                        <i class="fa-solid fa-eye toggle-pw" onclick="togglePw('confirmPassword', this)"></i>
                    </div>
                </div>

                <button type="submit" class="submit-btn" onclick="return validateForm()">
                    <i class="fa-solid fa-shield-halved"></i>&nbsp; Update Password
                </button>
            </form>

            <p class="footer-text">Remembered your password? <a href="LoginController">Login now</a></p>
        </div>
    </div>

    <script>
        function togglePw(id, icon) {
            const input = document.getElementById(id);
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'fa-solid fa-eye-slash toggle-pw';
            } else {
                input.type = 'password';
                icon.className = 'fa-solid fa-eye toggle-pw';
            }
        }

        function checkStrength(val) {
            const bars = [document.getElementById('s1'), document.getElementById('s2'),
                          document.getElementById('s3'), document.getElementById('s4')];
            const label = document.getElementById('strengthLabel');
            let score = 0;
            if (val.length >= 6) score++;
            if (val.length >= 10) score++;
            if (/[A-Z]/.test(val) && /[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;

            const colors = ['#ef4444', '#f97316', '#eab308', '#22c55e'];
            const labels = ['Very Weak', 'Weak', 'Medium', 'Strong'];
            bars.forEach((b, i) => { b.style.background = i < score ? colors[score - 1] : '#eee'; });
            label.textContent = val.length === 0 ? 'Enter password to check strength'
                               : labels[score - 1] || 'Very Weak';
            label.style.color = score > 0 ? colors[score - 1] : '#999';
        }

        function validateForm() {
            const pw = document.getElementById('newPassword').value;
            const cpw = document.getElementById('confirmPassword').value;
            if (pw.length < 6) {
                alert('Password must be at least 6 characters long!');
                return false;
            }
            if (pw !== cpw) {
                alert('Passwords do not match!');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
