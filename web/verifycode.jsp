<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OTP Verification | Chill Nest</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body { background-color: #f8fafc; margin: 0; font-family: 'Inter', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; }
        .login-wrapper { display: flex; width: 100%; max-width: 1000px; height: 650px; background: white; border-radius: 20px; overflow: hidden; box-shadow: 0 20px 50px rgba(0,0,0,0.1); margin: 20px; }
        .login-sidebar { flex: 1; background: linear-gradient(rgba(0, 86, 210, 0.75), rgba(0, 50, 160, 0.85)), url('https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&q=80&w=1000'); background-size: cover; background-position: center; padding: 50px; display: flex; flex-direction: column; justify-content: flex-end; color: white; position: relative; }
        .login-sidebar h2 { font-size: 2.6rem; line-height: 1.2; font-weight: 800; margin-bottom: 16px; }
        .steps { display: flex; flex-direction: column; gap: 15px; margin-top: 40px; }
        .step { display: flex; align-items: center; gap: 10px; font-size: 0.9rem; opacity: 0.5; }
        .step.active { opacity: 1; font-weight: 700; }
        .step.completed { opacity: 0.8; }
        .step-num { width: 28px; height: 28px; border-radius: 50%; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 0.8rem; }
        .step.active .step-num { background: white; color: #0056d2; }
        .step.completed .step-num { background: #4ade80; color: white; }
        
        .login-form-container { flex: 1; padding: 60px; display: flex; flex-direction: column; justify-content: center; }
        .login-header h1 { font-size: 1.7rem; font-weight: 700; margin-bottom: 8px; }
        .login-header p { color: #666; font-size: 0.9rem; margin-bottom: 30px; }
        .form-group { margin-bottom: 25px; }
        .otp-input { width: 100%; padding: 15px; border: 1.5px solid #eee; border-radius: 10px; font-size: 1.5rem; text-align: center; letter-spacing: 10px; font-weight: 800; outline: none; transition: 0.2s; }
        .otp-input:focus { border-color: #0056d2; box-shadow: 0 0 0 4px rgba(0, 86, 210, 0.1); }
        .submit-btn { width: 100%; padding: 15px; background: linear-gradient(135deg, #0056d2, #003fa0); color: white; border: none; border-radius: 10px; font-size: 1rem; font-weight: 700; cursor: pointer; }
        .alert { padding: 12px; border-radius: 10px; font-size: 0.85rem; margin-bottom: 20px; background: #fef2f2; color: #dc2626; border: 1px solid #fca5a5; display: flex; align-items: center; gap: 10px; }
    </style>
</head>
<body>
    <div class="login-wrapper">
        <div class="login-sidebar">
            <i class="fa-solid fa-shield-halved" style="position: absolute; top: 50px; left: 50px; font-size: 3rem; opacity: 0.3;"></i>
            <h2>Verify your identity.</h2>
            <p>This step helps us ensure it's you performing the password change.</p>
            <div class="steps">
                <div class="step completed">
                    <div class="step-num"><i class="fa-solid fa-check"></i></div>
                    <span>Email Verification</span>
                </div>
                <div class="step active">
                    <div class="step-num">2</div>
                    <span>Enter OTP</span>
                </div>
                <div class="step">
                    <div class="step-num">3</div>
                    <span>Reset Password</span>
                </div>
            </div>
        </div>
        <div class="login-form-container">
            <div class="login-header">
                <div style="width: 52px; height: 52px; background: #eff6ff; border-radius: 14px; display: flex; align-items: center; justify-content: center; margin-bottom: 20px; font-size: 1.4rem; color: #0056d2;">
                    <i class="fa-solid fa-key"></i>
                </div>
                <h1>Check your Email</h1>
                <p>We've sent a verification code to <strong><%= session.getAttribute("resetEmail") %></strong></p>
                
                <% String error = (String) request.getAttribute("error"); if (error != null) { %>
                    <div class="alert">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        <%= error %>
                    </div>
                <% } %>
            </div>
            
            <form action="VerifyCodeController" method="POST">
                <div class="form-group">
                    <label style="display: block; font-size: 0.8rem; font-weight: 700; margin-bottom: 8px; color: #333;">6-digit OTP Code</label>
                    <input type="text" name="authCode" class="otp-input" placeholder="000000" required maxlength="6" autofocus>
                </div>
                <button type="submit" class="submit-btn">Verify Code</button>
            </form>
            
            <div id="countdown-wrapper" style="text-align: center; margin-top: 25px; font-size: 0.85rem; color: #666;">
                Code expires in: <span id="timer" style="color: #dc2626; font-weight: 700;">30</span> seconds
            </div>
            
            <p style="text-align: center; margin-top: 15px; font-size: 0.85rem; color: #666;">
                Haven't received the code? 
                <a href="ForgotPasswordController" style="color: #0056d2; font-weight: 700; text-decoration: none;">Click here to resend</a>
            </p>

            <script>
                let timeLeft = 30;
                const timerElement = document.getElementById('timer');
                const countdownWrapper = document.getElementById('countdown-wrapper');

                const countdown = setInterval(function() {
                    timeLeft--;
                    if (timeLeft >= 0) {
                        timerElement.innerText = timeLeft;
                    }
                    
                    if (timeLeft <= 0) {
                        clearInterval(countdown);
                        countdownWrapper.innerHTML = '<span style="color: #dc2626; font-weight: 700;">Code expired!</span> Please resend a new one.';
                    }
                }, 1000);
            </script>
        </div>
    </div>
</body>
</html>
