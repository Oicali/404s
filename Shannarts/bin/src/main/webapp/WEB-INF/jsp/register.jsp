<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Shannarts</title>
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
            padding: 20px 70px;
        }

        .form-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-title {
            font-family: 'Cinzel Decorative', cursive;
            font-size: 34px;
            color: #8b1538;
            margin-bottom: 8px;
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
            margin-bottom: 20px;
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
            margin: 20px 0 25px;
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

        .form-row {
            display: flex;
            gap: 18px;
            margin-bottom: 15px;
        }

        .form-group {
            flex: 1;
            position: relative;
        }
        
        .form-group:not(.form-row .form-group) {
            margin-bottom: 15px;
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
        
        .form-input.success {
            border-color: #28a745;
            background: #f0fff4;
        }

        .input-icon {
            position: absolute;
            right: 18px;
            top: 18px;
            color: #aaa;
            cursor: pointer;
            font-size: 16px;
            transition: color 0.3s ease;
            z-index: 10;
        }
        
        .input-icon:hover {
            color: #8b1538;
        }
        
        .error-message {
            color: #dc3545;
            font-size: 12px;
            margin-top: 5px;
            margin-bottom: 10px;
            display: none;
            font-weight: 500;
        }
        
        .error-message.show {
            display: block;
            animation: shake 0.3s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-3px); }
            75% { transform: translateX(3px); }
        }
        
        .password-strength {
            margin-top: 5px;
            margin-bottom: 10px;
            font-size: 12px;
        }
        
        .strength-bar {
            height: 4px;
            background: #e0e0e0;
            border-radius: 2px;
            overflow: hidden;
            margin-top: 5px;
        }
        
        .strength-bar-fill {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background: #dc3545; width: 33%; }
        .strength-medium { background: #ffc107; width: 66%; }
        .strength-strong { background: #28a745; width: 100%; }
        
        .checkbox-wrapper {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            align-items: flex-start;
            margin-bottom: 22px;
        }

        .checkbox-group {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            flex: 1 1 45%;
            margin-bottom: 0;
        }

        .checkbox {
            margin-top: 3px;
            cursor: pointer;
            accent-color: #8b1538;
            transform: scale(1.1);
        }

        .checkbox-label {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
            cursor: pointer;
            font-weight: 400;
        }

        .checkbox-label a {
            color: #8b1538;
            text-decoration: none;
            font-weight: 600;
        }
        
        .checkbox-label a:hover {
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
            margin-bottom: 20px;
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

        .login-link {
            text-align: center;
            font-size: 15px;
            color: #666;
            padding-bottom: 20px;
            font-weight: 500;
        }

        .login-link a {
            color: #8b1538;
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s ease;
        }
        
        .login-link a:hover {
            opacity: 0.8;
        }
        
        .message {
            padding: 12px;
            margin-bottom: 15px;
            border-radius: 8px;
            text-align: center;
            animation: slideDown 0.3s ease;
            font-weight: 500;
            font-size: 14px;
        }
		

		  /* ================================================= */
		  /* 🔥 FIX FOR DOUBLE PASSWORD ICON START */
		  /* ================================================= */

		  /* Hide the native password reveal button for Microsoft Edge/IE */
		  input[type="password"]::-ms-reveal,
		  input[type="password"]::-ms-clear {
		      display: none;
		      width: 0;
		      height: 0;
		  }

		  /* Hide the native password reveal button for Firefox */
		  input[type="password"] {
		      /* This is generally used for custom styling control in Firefox */
		      -moz-appearance: textfield; 
		  }
		  
		  /* Hide the native password reveal button for Chrome/Safari/Brave */
		  /* The input-icon position often overlaps the native button, but this removes it */
		  input[type="password"]::-webkit-inner-spin-button,
		  input[type="password"]::-webkit-outer-spin-button {
		      -webkit-appearance: none;
		      margin: 0;
		  }
		  
		  /* Set appearance to none to remove any default browser styling that might interfere */
		  input[type="password"] {
		      -webkit-appearance: none;
		      -moz-appearance: none;
		      appearance: none;
		  }
		  
		  /* You may need this if the above is not enough, to override specific icon positioning */
		  .form-group input[type="password"] {
		      padding-right: 50px !important; /* Ensure space for *your* icon, not the native one */
		  }

		  /* ================================================= */
		  /* 🔥 FIX FOR DOUBLE PASSWORD ICON END */
		  /* ================================================= */
        
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
            .form-row {
                flex-direction: column;
                gap: 0;
                margin-bottom: 0;
            }
            .checkbox-wrapper {
                flex-direction: column;
                gap: 10px;
            }
            .checkbox-group {
                flex: none;
                width: 100%;
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
            <a href="register" class="tab active">Create Account</a>
            <a href="login" class="tab">Sign in</a>
        </div>
 
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">EXPLORE OUR SHOP</h2>
                <p class="form-subtitle">Create your account in just a few steps</p>
            </div>
            
            <c:if test="${not empty message}">
                <div class="message success">${message}</div>
            </c:if>
            
            <c:if test="${not empty error}">
                <div class="message error" id="errorMessage">${error}</div>
            </c:if>
 
            <div class="social-login">
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
 
            <div class="divider">OR SIGN UP WITH EMAIL</div>

            <form id="registerForm" action="save" method="post" novalidate>
                <div class="form-row">
                    <div class="form-group">
                        <input type="text" name="firstname" id="firstname" class="form-input" placeholder="First Name" required value="${user.firstname}">
                        <i class="fas fa-user input-icon"></i>
                        <div class="error-message" id="firstnameError">First name is required</div>
                    </div>
                    <div class="form-group">
                        <input type="text" name="lastname" id="lastname" class="form-input" placeholder="Last Name" required value="${user.lastname}">
                        <i class="fas fa-user input-icon"></i>
                        <div class="error-message" id="lastnameError">Last name is required</div>
                    </div>
                </div>
 
                <div class="form-group">
                    <input type="email" name="email" id="email" class="form-input" placeholder="Email Address" required value="${user.email}">
                    <i class="fas fa-envelope input-icon"></i>
                    <div class="error-message" id="emailError">Please enter a valid email</div>
                </div>
 
                <div class="form-group">
                    <input type="tel" name="phone" id="phone" class="form-input" placeholder="Phone Number (09XXXXXXXXX)" maxlength="11" value="${user.phone}">
                    <i class="fas fa-phone input-icon"></i>
                    <div class="error-message" id="phoneError">Phone number must be 11 digits starting with 09</div>
                </div>
 
				<!-- ===== HTML ===== -->
				<div class="form-group">
				  <input type="password" name="password" id="password" class="form-input" placeholder="Password (min. 8 characters)" required>
				  <!-- initial icon set to fa-eye-slash because input type is "password" (hidden) -->
				  <i class="fas fa-eye-slash input-icon" id="togglePassword" role="button" aria-label="Show password" title="Show password"></i>
				  <div class="password-strength" id="passwordStrength" style="display: none;">
				    <div class="strength-bar">
				      <div class="strength-bar-fill" id="strengthBar"></div>
				    </div>
				    <span id="strengthText"></span>
				  </div>
				  <div class="error-message" id="passwordError">Password must be at least 8 characters with uppercase, lowercase, and number</div>
				</div>

				<div class="form-group">
				  <input type="password" name="confirmPassword" id="confirmPassword" class="form-input" placeholder="Confirm Password" required>
				  <i class="fas fa-eye-slash input-icon" id="toggleConfirmPassword" role="button" aria-label="Show confirm password" title="Show confirm password"></i>
				  <div class="error-message" id="confirmPasswordError">Passwords do not match</div>
				</div>

                <div class="checkbox-wrapper">
                    <div class="checkbox-group">
                        <input type="checkbox" class="checkbox" id="terms" required>
                        <label class="checkbox-label" for="terms">
                            I accept the <a href="#">Terms and Conditions</a>. You agree to our <a href="#">Terms of Service and Privacy Policy</a>
                        </label>
                    </div>
    
                    <div class="checkbox-group">
                        <input type="checkbox" class="checkbox" id="promotions" name="promotions">
                        <label class="checkbox-label" for="promotions">
                            Send me exclusive shop releases and promotions. Be the first to know about new collections and special offers
                        </label>
                    </div>
                </div>
 
                <button type="submit" class="submit-btn" id="submitBtn">Create Account</button>
            </form>
 
            <p class="login-link">Already have an account? <a href="login">Sign in</a></p>
        </div>
    </div>

	<script>
	     // ================== START: UPDATED CODE FOR EMAIL ERROR ==================
	     // This block handles the "Email already in use" error from the server.
	     <c:if test="${not empty error}">
	         document.addEventListener('DOMContentLoaded', function() {
	             // IMPORTANT: Check if the error message is about the email.
	             const errorMsg = '${error}'.toLowerCase();
	             
	             if (errorMsg.includes('email') && errorMsg.includes('use')) {
	                 const emailField = document.getElementById('email');
	                 const emailErrorDiv = document.getElementById('emailError');
	                 const mainErrorDiv = document.getElementById('errorMessage');

	                 if (emailField) {
	                     // 1. Clears *only* the email field, which was loaded with ${user.email}
	                     emailField.value = ''; 
	                     emailField.classList.add('error'); 
	                     emailField.focus(); 
	                 }

	                 if (emailErrorDiv) {
	                     // 2. Shows the specific error message right below the email field
	                     emailErrorDiv.textContent = 'This email is already in use.';
	                     emailErrorDiv.classList.add('show');
	                     emailErrorDiv.style.display = 'block'; 
	                 }
	                 
	                 // 3. Optional: Hide the generic error message at the top
	                 if (mainErrorDiv) {
	                     mainErrorDiv.style.display = 'none';
	                 }
	             } else {
	                 // If it's another type of error, make sure the main error is visible
	                 const mainErrorDiv = document.getElementById('errorMessage');
	                 if (mainErrorDiv) {
	                     mainErrorDiv.style.display = 'block';
	                 }
	             }
	         });
	     </c:if>
        // =================== END: UPDATED CODE FOR EMAIL ERROR ===================


        // --- ALL YOUR ORIGINAL JAVASCRIPT REMAINS THE SAME BELOW ---

        // Password toggle functionality
        const togglePassword = document.getElementById('togglePassword');
        const password = document.getElementById('password');
        const toggleConfirmPassword = document.getElementById('toggleConfirmPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        
        if (togglePassword) {
            togglePassword.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
                password.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
        
        if (toggleConfirmPassword) {
            toggleConfirmPassword.addEventListener('click', function(e) {
                e.preventDefault();
                e.stopPropagation();
                const type = confirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
                confirmPassword.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        }
        
        // Password strength checker
        password.addEventListener('input', function() {
            const value = this.value;
            const strengthIndicator = document.getElementById('passwordStrength');
            const strengthBar = document.getElementById('strengthBar');
            const strengthText = document.getElementById('strengthText');
            
            if (value.length > 0) {
                strengthIndicator.style.display = 'block';
                let strength = 0;
                
                if (value.length >= 8) strength++;
                if (/[a-z]/.test(value) && /[A-Z]/.test(value)) strength++;
                if (/[0-9]/.test(value)) strength++;
                if (/[^a-zA-Z0-9]/.test(value)) strength++;
                
                strengthBar.className = 'strength-bar-fill';
                if (strength <= 1) {
                    strengthBar.classList.add('strength-weak');
                    strengthText.textContent = 'Weak password';
                    strengthText.style.color = '#dc3545';
                } else if (strength <= 2) {
                    strengthBar.classList.add('strength-medium');
                    strengthText.textContent = 'Medium password';
                    strengthText.style.color = '#ffc107';
                } else {
                    strengthBar.classList.add('strength-strong');
                    strengthText.textContent = 'Strong password';
                    strengthText.style.color = '#28a745';
                }
            } else {
                strengthIndicator.style.display = 'none';
            }
        });
        
        // Form validation
        const form = document.getElementById('registerForm');
        const email = document.getElementById('email');
        const phone = document.getElementById('phone');
        const firstname = document.getElementById('firstname');
        const lastname = document.getElementById('lastname');
        
        phone.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9]/g, '');
            if (this.value.length > 11) {
                this.value = this.value.slice(0, 11);
            }
        });
        
        function validateField(field, errorElement, validationFn, errorMsg) {
            field.addEventListener('blur', function() {
                if (!validationFn(this.value)) {
                    this.classList.add('error');
                    this.classList.remove('success');
                    errorElement.textContent = errorMsg;
                    errorElement.classList.add('show');
                } else {
                    this.classList.remove('error');
                    this.classList.add('success');
                    errorElement.classList.remove('show');
                }
            });
            
            field.addEventListener('input', function() {
                if (this.classList.contains('error') && validationFn(this.value)) {
                    this.classList.remove('error');
                    this.classList.add('success');
                    errorElement.classList.remove('show');
                }
            });
        }
        
        validateField(firstname, document.getElementById('firstnameError'), 
            val => val.trim().length > 0, 'First name is required');
        
        validateField(lastname, document.getElementById('lastnameError'), 
            val => val.trim().length > 0, 'Last name is required');
        
        validateField(email, document.getElementById('emailError'), 
            val => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(val), 'Please enter a valid email');
        
        validateField(phone, document.getElementById('phoneError'), 
            val => !val || /^09[0-9]{9}$/.test(val), 'Phone number must be 11 digits starting with 09');
        
        validateField(password, document.getElementById('passwordError'), 
            val => val.length >= 8 && /[A-Z]/.test(val) && /[a-z]/.test(val) && /[0-9]/.test(val), 
            'Password must be at least 8 characters with uppercase, lowercase, and number');
        
        confirmPassword.addEventListener('blur', function() {
            const errorElement = document.getElementById('confirmPasswordError');
            if (this.value !== password.value) {
                this.classList.add('error');
                this.classList.remove('success');
                errorElement.textContent = 'Passwords do not match';
                errorElement.classList.add('show');
            } else if (this.value.length > 0) {
                this.classList.remove('error');
                this.classList.add('success');
                errorElement.classList.remove('show');
            }
        });
        
        confirmPassword.addEventListener('input', function() {
            const errorElement = document.getElementById('confirmPasswordError');
            if (this.value === password.value && this.value.length > 0) {
                this.classList.remove('error');
                this.classList.add('success');
                errorElement.classList.remove('show');
            }
        });
        
        form.addEventListener('submit', function(e) {
            let isValid = true;
            
            if (firstname.value.trim().length === 0) {
                firstname.classList.add('error');
                document.getElementById('firstnameError').classList.add('show');
                isValid = false;
            }
            
            if (lastname.value.trim().length === 0) {
                lastname.classList.add('error');
                document.getElementById('lastnameError').classList.add('show');
                isValid = false;
            }
            
            if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
                email.classList.add('error');
                document.getElementById('emailError').textContent = 'Please enter a valid email';
                document.getElementById('emailError').classList.add('show');
                isValid = false;
            }
            
            if (phone.value && !/^09[0-9]{9}$/.test(phone.value)) {
                phone.classList.add('error');
                document.getElementById('phoneError').classList.add('show');
                isValid = false;
            }
            
            const pwd = password.value;
            if (pwd.length < 8 || !/[A-Z]/.test(pwd) || !/[a-z]/.test(pwd) || !/[0-9]/.test(pwd)) {
                password.classList.add('error');
                document.getElementById('passwordError').classList.add('show');
                isValid = false;
            }
            
            if (confirmPassword.value !== password.value) {
                confirmPassword.classList.add('error');
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
                document.getElementById('confirmPasswordError').classList.add('show');
                isValid = false;
            }
            
            if (!document.getElementById('terms').checked) {
                alert('Please accept the Terms and Conditions to continue');
                isValid = false;
            }
            
            if (!isValid) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>