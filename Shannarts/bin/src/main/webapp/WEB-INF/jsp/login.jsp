<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Shannarts</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700&family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-image: url('<%= request.getContextPath() %>/images/bgi.png');
            font-family: 'Cormorant Garamond', serif;
            position: relative;
            width: 100%;
            min-height: 100vh;
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 0;
        }
        
        /* FIX: Hides the browser's default password reveal icon to prevent a double icon */
        input[type="password"]::-ms-reveal {
            display: none;
        }

        .left-panel {
            flex: 0 0 38%;
            height: 90vh;
            max-height: 800px;
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 30px;
            border-top-right-radius: 190px;
            border-bottom-right-radius: 190px;
        }

        .brand-container {
            margin-bottom: 50px; 
            text-align: center;
            margin-left: -60px;
            color: white;
            z-index: 2;
        }

        .logo {
            width: 140px;
            height: 140px;
            background: #8b1538;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 25px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
        }
        
        .logo img {
            width: 180px;
            height: 180px;
            object-fit: contain;
        }

        .brand-name {
            font-family: 'Cinzel Decorative', cursive;
            font-size: 44px;
            font-weight: 700;
            color: #8b1538;
            text-shadow: 1px 1px 2px rgba(255, 255, 255, 0.3);
            margin-bottom: 12px;
            letter-spacing: 2px;
        }

        .tagline {
            font-size: 17px;
            font-style: italic;
            color: #8b1538;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .description {
            font-size: 14px;
            line-height: 1.7;
            color: #6d1029;
            max-width: 350px;
            margin: 0 auto 30px;
            font-weight: 400;
        }

        .cta-button {
            background: #8b1538;
            color: white;
            padding: 14px 40px;
            border: none;
            border-radius: 30px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            font-family: 'Cormorant Garamond', serif;
        }

        .cta-button:hover {
            background: #6d1029;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
        }

        .contact-info {
            position: absolute;
            bottom: 25px;
            left: 70px;
            font-size: 12px;
            color: #8b1538;
            font-weight: 500;
        }

        .contact-info div {
            margin-bottom: 6px;
            display: flex;
            align-items: center;
        }

        .contact-info i {
            margin-right: 10px;
            width: 18px;
            text-align: center;
        }

        .right-panel {
            flex: 1;
            height: 90vh;
            max-height: 800px;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow-y: auto;
        }

        .auth-tabs {
            display: flex;
            justify-content: flex-end;
            padding: 30px 60px 0;
            position: relative;
            border-bottom: none;
        }

        .auth-tabs::after {
            content: "";
            position: absolute;
            bottom: 0;
            right: 60px;
            width: 700px;
            height: 1px;
            background: #f0f0f0;
        }

        .tab {
            padding: 15px 30px;
            background: none;
            border: none;
            font-size: 17px;
            cursor: pointer;
            color: #999;
            border-bottom: 3px solid transparent;
            text-decoration: none;
            transition: all 0.3s ease;
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }

        .tab.active {
            color: #8b1538;
            border-bottom-color: #8b1538;
        }
        
        .tab:hover {
            color: #8b1538;
        }

        .form-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 40px 70px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .form-title {
            font-family: 'Cinzel Decorative', cursive;
            font-size: 34px;
            color: #8b1538;
            margin-bottom: 10px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .form-subtitle {
            font-size: 16px;
            color: #888;
            font-weight: 400;
        }
        
        .social-login {
            text-align: center;
            margin-bottom: 25px;
        }
        
        .social-text {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
            font-weight: 500;
        }

        .social-buttons {
            display: flex;
            justify-content: center;
            gap: 18px;
            margin-bottom: 15px;
        }

        .social-btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }
        
        .social-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.25);
        }

        .google { 
            background: white;
            padding: 10px;
        }
        
        .google img {
            width: 24px;
            height: 24px;
        }
        
        .facebook { background: #3b5998; }
        .instagram { background: linear-gradient(45deg, #f09433, #e6683c, #dc2743, #cc2366, #bc1888); }

        .divider {
            display: flex;
            align-items: center;
            margin: 25px 0 30px;
            color: #999;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .divider::before,
        .divider::after {
            content: '';
            flex: 1;
            height: 1px;
            background: #e0e0e0;
        }

        .divider::before { margin-right: 12px; }
        .divider::after { margin-left: 12px; }

        .form-group {
            margin-bottom: 25px; /* Increased margin for error message space */
            position: relative;
        }

        .form-input {
            width: 100%;
            padding: 16px 50px 16px 20px;
            border: 1px solid #f0d5e0;
            background: #fdf7f9;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
            transition: all 0.3s ease;
            font-family: 'Cormorant Garamond', serif;
            color: #333;
        }
        
        .form-input:focus {
            background: #fff;
            border-color: #8b1538;
            box-shadow: 0 0 0 3px rgba(139, 21, 56, 0.1);
        }
        
        .form-input.error {
            border-color: #dc3545;
            background: #fff5f5;
        }

        .input-icon {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #aaa;
            cursor: pointer;
            font-size: 16px;
            transition: color 0.3s ease;
            pointer-events: auto;
        }
        
        .input-icon:hover {
            color: #8b1538;
        }
        
        /* FIX: Positions the error message absolutely to prevent moving other elements */
        .error-message {
            color: #dc3545;
            font-size: 12px;
            font-weight: 500;
            position: absolute;
            top: 100%;
            left: 4px;
            margin-top: 3px;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, transform 0.3s ease;
        }
        
        .error-message.show {
            opacity: 1;
            visibility: visible;
            animation: shake 0.3s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-3px); }
            75% { transform: translateX(3px); }
        }

        .form-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .checkbox {
            margin: 0;
            cursor: pointer;
            accent-color: #8b1538;
            transform: scale(1.1);
        }

        .checkbox-label {
            color: #666;
            cursor: pointer;
            font-weight: 400;
        }

        .forgot-password {
            color: #8b1538;
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s ease;
        }

        .forgot-password:hover {
            opacity: 0.8;
            text-decoration: underline;
        }

        .submit-btn {
            width: 100%;
            background: #8b1538;
            color: white;
            padding: 17px;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            margin-bottom: 25px;
            transition: all 0.3s ease;
            font-family: 'Cormorant Garamond', serif;
            box-shadow: 0 4px 15px rgba(139, 21, 56, 0.3);
            letter-spacing: 0.5px;
        }

        .submit-btn:hover {
            background: #6d1029;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(139, 21, 56, 0.4);
        }
        
        .submit-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .signup-link {
            text-align: center;
            font-size: 15px;
            color: #666;
            font-weight: 500;
        }

        .signup-link a {
            color: #8b1538;
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s ease;
        }
        
        .signup-link a:hover {
            opacity: 0.8;
        }
        
        .message {
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            text-align: center;
            animation: slideDown 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }
        
        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        
        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        @media (max-width: 992px) {
            body {
                flex-direction: column;
                padding: 20px;
                overflow-y: auto;
                justify-content: flex-start;
            }
            
            .left-panel, .right-panel {
                flex: none;
                width: 100%;
                height: auto;
                max-height: none;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            }

            .left-panel {
                min-height: 200px;
                padding: 30px 20px 20px;
                border-top-right-radius: 15px;
                border-bottom-right-radius: 15px;
                margin-bottom: 20px;
            }

            .right-panel {
                border-radius: 15px;
            }

            .brand-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding-bottom: 20px;
                margin-left: 0;
            }
            
            .brand-name { font-size: 38px; }
            .tagline { font-size: 16px; }
            .description { 
                font-size: 13px; 
                max-width: 90%; 
                margin-bottom: 20px; 
            }
            .logo { 
                width: 120px; 
                height: 120px; 
                margin-bottom: 20px; 
            }
            .logo img {
                width: 90px;
                height: 90px;
            }
            .contact-info {
                position: static;
                margin-top: 20px;
                text-align: center;
                width: 100%;
                padding: 0 10px;
                left: auto;
            }
            .contact-info div {
                justify-content: center;
                margin-bottom: 5px;
            }

            .auth-tabs {
                padding: 20px 30px 0;
            }
            
            .auth-tabs::after {
                right: 30px;
                width: calc(100% - 60px);
            }
            
            .form-container {
                padding: 20px 30px;
            }
            
            .form-options {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>
    <div class="left-panel">
        <div class="brand-container">
            <div class="logo">
                <img src="<%= request.getContextPath() %>/images/1.png" alt="Shannarts Logo">
            </div>
            <div class="brand-name">SHANNARTS</div>
            <div class="tagline">Gifts Crafted with Love and Care</div>
            
            <div class="description">
                Welcome to Shannarts, where every creation tells a story and every gift carries the warmth of handcrafted love. Founded with a passion for bringing joy through art, we specialize in creating unique, personalized pieces that celebrate life's special moments.
            </div>

            <button class="cta-button">ORDER YOURS NOW!</button>
        </div>
        <div class="contact-info">
            <div><i class="fas fa-map-marker-alt"></i>Dasmariñas City Cavite</div>
            <div><i class="fas fa-phone"></i>09081915441</div>
            <div><i class="fab fa-facebook"></i>Shannarts</div>
            <div><i class="fas fa-envelope"></i>shannarts@gmail.com</div>
        </div>
    </div>
 
    <div class="right-panel">
        <div class="auth-tabs">
            <a href="register" class="tab">Create Account</a>
            <a href="login" class="tab active">Sign in</a>
        </div>
 
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">Sign In to Your Account</h2>
                <p class="form-subtitle">Welcome back! Please enter your details</p>
            </div>
            
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="message error">${error}</div>
            </c:if>
 
            <div class="social-login">
                <p class="social-text">EXPLORE OUR SHOP</p>
                <p class="form-subtitle" style="margin-bottom: 20px;">Quick sign in with your social account</p>
                <div class="social-buttons">
                    <button class="social-btn google" onclick="alert('Google sign-in coming soon!')">
                        <img src="https://www.google.com/favicon.ico" alt="Google">
                    </button>
                    <button class="social-btn instagram" onclick="alert('Instagram sign-in coming soon!')">
                        <i class="fab fa-instagram"></i>
                    </button>
                    <button class="social-btn facebook" onclick="alert('Facebook sign-in coming soon!')">
                        <i class="fab fa-facebook-f"></i>
                    </button>
                </div>
            </div>
 
            <div class="divider">OR SIGN IN WITH EMAIL</div>
 
            <form id="loginForm" action="login" method="post" novalidate>
                <div class="form-group">
                    <%-- This value attribute keeps the email filled in after a login error --%>
                    <input type="email" name="email" id="email" class="form-input" placeholder="Email Address" required value="${param.email}">
                    <i class="fas fa-envelope input-icon"></i>
                    <div class="error-message" id="emailError">Please enter a valid email address</div>
                </div>

                <div class="form-group">
                    <input type="password" name="password" id="password" class="form-input" placeholder="Password" required>
                    <i class="fas fa-eye-slash input-icon" id="togglePassword"></i>
                    <div class="error-message" id="passwordError">Password is required</div>
                </div>

                <div class="form-options">
                    <div class="checkbox-group">
                        <input type="checkbox" class="checkbox" id="remember" name="remember">
                        <label class="checkbox-label" for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-password">Forgot password?</a>
                </div>

                <button type="submit" class="submit-btn">Sign In</button>
            </form>

            <p class="signup-link">Don't have an account? <a href="register">Sign up</a></p>
        </div>
    </div>
    
    <script>
        
        const togglePassword = document.getElementById('togglePassword');
        const passwordInput = document.getElementById('password');
        
        if (togglePassword) {
            togglePassword.addEventListener('click', function(e) {
                e.preventDefault();
                const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
                passwordInput.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
        
        const form = document.getElementById('loginForm');
        const emailInput = document.getElementById('email');
        
        function validateEmail() {
            const errorElement = document.getElementById('emailError');
            if (emailInput.value.trim().length > 0 && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(emailInput.value)) {
                emailInput.classList.add('error');
                errorElement.classList.add('show');
                return false;
            } else {
                emailInput.classList.remove('error');
                errorElement.classList.remove('show');
                return true;
            }
        }

        function validatePassword() {
            const errorElement = document.getElementById('passwordError');
             if (passwordInput.value.trim().length === 0) {
                passwordInput.classList.add('error');
                errorElement.classList.add('show');
                return false;
            } else {
                passwordInput.classList.remove('error');
                errorElement.classList.remove('show');
                return true;
            }
        }

        emailInput.addEventListener('blur', validateEmail);
        passwordInput.addEventListener('blur', validatePassword);
        
        form.addEventListener('submit', function(e) {
            const isEmailValid = validateEmail();
            const isPasswordValid = validatePassword();
            
            if (!isEmailValid || !isPasswordValid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>