<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings - Shannarts</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
     
        @import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700&family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap');
        
      
        :root {
            --primary-dark: #8b1538; 
            --primary-light: #f5e4ed; 
            --secondary-text: #6d1029; 
            --subtle-shadow: rgba(0, 0, 0, 0.1);
            --header-font: 'Cinzel Decorative', cursive;
            --body-font: 'Cormorant Garamond', serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--body-font);
            min-height: 100vh;
            display: flex; 
            
            background-image: url('<%= request.getContextPath() %>/images/dashbg.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-color: #fcfcfc; 
        }

        .sidebar {
            width: 280px; 
            height: 100vh; 
            position: fixed; 
            top: 0;
            left: 0;
            padding: 30px 20px;
            z-index: 1000;
            box-shadow: 4px 0 20px rgba(0, 0, 0, 0.3);
            display: flex;
            flex-direction: column;
            
            background: linear-gradient(to bottom, #ffe4f0, #ffc7da); 
        }

        .logo-container {
            display: flex;
            align-items: center;
            padding: 0 10px;
            margin-bottom: 40px;
			margin-left: -10px;
        }

        .logo-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
            flex-shrink: 0; 
            
            width: 50px; 
            height: 50px;
            border-radius: 50%; 
            border: 3px solid var(--primary-dark); 
            background-color: white;
            box-shadow: 0 2px 8px var(--subtle-shadow);
            overflow: hidden; 
        }

        .logo-wrapper img {          
			width: 60px;
			height: 60px;
            object-fit: contain;
        }
        
       

        .brand-name {
            font-family: var(--header-font);
            font-size: 24px;
            font-weight: 700;
            color: var(--primary-dark);
            letter-spacing: 1px;
			margin-left: 0; 
			
        }

        .nav-links {
            flex-grow: 1; 
            list-style: none;
            padding: 0;
            margin-bottom: 30px;
        }

        .nav-link {
            display: block;
            padding: 15px 20px;
            margin: 8px 0;
            color: var(--secondary-text);
            text-decoration: none;
            font-size: 18px;
            font-weight: 600;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            background: transparent;
        }

        .nav-link i {
            margin-right: 15px;
            font-size: 20px;
            width: 20px;
            text-align: center;
        }

        .nav-link.active,
        .nav-link:hover {
            background-color: var(--primary-dark);
            color: white;
            box-shadow: 0 4px 10px rgba(139, 21, 56, 0.4);
            transform: scale(1.02); 
        }
        
        .logout-btn {
            width: 100%;
            padding: 15px;
            background: var(--primary-dark);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(139, 21, 56, 0.4);
            text-decoration: none;
            text-align: center;
            font-family: var(--body-font);
        }

        .logout-btn:hover {
            background: #6d1029;
            box-shadow: 0 6px 20px rgba(139, 21, 56, 0.6);
        }

        .main-content-wrapper {
            flex-grow: 1;
            margin-left: 280px; 
            padding: 40px;
            background-color: transparent;
            min-height: 100vh;
        }

        .dashboard-container {
           
            background: rgba(255, 255, 255, 0.95); 
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15); 
        }
        
       
        .welcome-header {
            margin-bottom: 40px;
        }

        .welcome-header h1 {
            font-family: var(--header-font);
            font-size: 44px;
            color: var(--primary-dark);
            margin-bottom: 5px;
            font-weight: 700;
            letter-spacing: 1px;
        }
        
        .welcome-header p {
            font-size: 18px;
            color: #777;
            font-weight: 500;
        }
        
 
        .settings-grid {
            display: grid;
            grid-template-columns: 1fr 1fr; 
            gap: 30px;
        }

        .section-card {
            background: #fff;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 4px 12px var(--subtle-shadow);
        }

        .section-card h2 {
            font-family: var(--header-font);
            font-size: 28px;
            color: var(--primary-dark);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--primary-light);
            padding-bottom: 10px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: var(--secondary-text);
        }
        
        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-family: var(--body-font);
            font-size: 16px;
            transition: border-color 0.3s ease;
        }
        
        .form-group input:focus {
            border-color: var(--primary-dark);
            outline: none;
            box-shadow: 0 0 0 3px var(--primary-light);
        }
        
        .submit-btn {
            padding: 10px 20px;
            background: var(--primary-dark);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
        }
        
        .submit-btn:hover {
            background: var(--secondary-text);
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            font-weight: 600;
        }
        
        .alert-success {
            background-color: #d1e7dd;
            color: #0f5132;
            border: 1px solid #badbcc;
        }
        
        .alert-error {
            background-color: #f8d7da;
            color: #842029;
            border: 1px solid #f5c2c7;
        }
        
        /* User Management Table Styles */
        .users-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 16px;
            margin-top: 20px;
        }

        .users-table th, .users-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .users-table th {
            background-color: var(--primary-light);
            color: var(--secondary-text);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }

        .users-table tbody tr:hover {
            background-color: #fcfcfc;
        }
        
        .role-badge {
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .role-admin { background-color: #ffe4f0; color: var(--primary-dark); }
        .role-user { background-color: #e0f7fa; color: #00bcd4; }

        @media (max-width: 1024px) {
            .main-content-wrapper {
                margin-left: 250px;
                padding: 30px;
            }
            .sidebar {
                width: 250px;
            }
            .settings-grid {
                grid-template-columns: 1fr; /* Stack profile and password forms on smaller screens */
            }
        }
        
        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }
            
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                min-height: 100px;
                padding: 20px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }
            
            .main-content-wrapper {
                margin-left: 0;
                padding: 20px;
            }
            
            .dashboard-container {
                padding: 20px;
            }
            
            .nav-links {
                display: flex;
                flex-wrap: wrap;
                gap: 5px;
                margin-bottom: 10px;
            }
            
            .nav-link {
                padding: 10px 15px;
                margin: 0;
                font-size: 16px;
                text-align: center;
            }
            
            .nav-link i {
                margin-right: 8px;
            }
            
            .logout-btn {
                margin-top: 15px;
            }

            .logo-container {
                margin-bottom: 20px;
                justify-content: center;
            }
            
        }
    </style>
</head>
<body>

    <div class="sidebar">
        
        <div class="logo-container">
            <div class="logo-wrapper">
                <img src="<%= request.getContextPath() %>/images/1.png" alt="Shannarts Logo" />
            </div>
            <div class="brand-name">SHANNARTS</div>
        </div>

       
        <ul class="nav-links">
            <li><a href="dashboard" class="nav-link"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            <li><a href="products" class="nav-link"><i class="fas fa-box-open"></i> Products</a></li>
            <li><a href="orders" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="transactions" class="nav-link"><i class="fas fa-receipt"></i> Transactions</a></li>
            <li><a href="settings" class="nav-link active"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

     
        <a href="logout" class="logout-btn">Logout</a>
    </div>

 
    <div class="main-content-wrapper">
        
        <div class="dashboard-container">
            
            <div class="welcome-header">
                <h1>Account Settings</h1>
                <p>Manage your profile details and access administrator tools.</p>
            </div>

            <c:if test="${not empty message}">
                <div class="alert alert-success">${message}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

           
            <div class="settings-grid">
                
                <!-- Profile Update Card -->
                <div class="section-card">
                    <h2><i class="fas fa-user-edit"></i> Profile Details</h2>
                    <form action="update-profile?action=profile" method="post">
                        
                        <div class="form-group">
                            <label for="firstname">First Name</label>
                            <input type="text" id="firstname" name="firstname" value="${loggedUser.firstname}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastname">Last Name</label>
                            <input type="text" id="lastname" name="lastname" value="${loggedUser.lastname}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" value="${loggedUser.email}" required>
                        </div>
                        
                        <button type="submit" class="submit-btn">Save Profile</button>
                    </form>
                </div>

                <!-- Password Change Card -->
                <div class="section-card">
                    <h2><i class="fas fa-lock"></i> Change Password</h2>
                    <form action="update-profile?action=password" method="post">
                        
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        
                        <button type="submit" class="submit-btn">Update Password</button>
                    </form>
                </div>
            </div>
            
            <br>
            
            <!-- ADMIN ONLY: User Management Section -->
            <c:if test="${loggedUser.role == 0}">
                <div class="section-card" style="grid-column: 1 / -1; margin-top: 30px;">
                    <h2><i class="fas fa-user-shield"></i> Administrator: User Management</h2>

                    <!-- Promote User Form -->
                    <h3 style="font-size: 20px; color: var(--secondary-text); margin-bottom: 10px;">Promote User to Admin</h3>
                    <form action="promote-user" method="post" style="display: flex; gap: 10px; margin-bottom: 30px;">
                        <div class="form-group" style="flex-grow: 1; margin-bottom: 0;">
                            <label for="targetEmail" style="font-weight: 400; font-size: 14px;">Enter User Email to Promote</label>
                            <input type="email" id="targetEmail" name="targetEmail" placeholder="user@example.com" required>
                        </div>
                        <button type="submit" class="submit-btn" style="align-self: flex-end; padding: 10px 30px;">Promote</button>
                    </form>

                    <!-- User List Table -->
                    <h3 style="font-size: 20px; color: var(--secondary-text); margin-bottom: 15px;">Registered Users (${users.size()})</h3>
                    <table class="users-table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Role</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.firstname} ${user.lastname}</td>
                                    <td>${user.email}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.role == 0}">
                                                <span class="role-badge role-admin">Admin</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="role-badge role-user">User</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${user.role != 0}">
                                            <!-- Note: Actual delete/demote logic needs separate controller endpoints -->
                                            <a href="#" style="color: #0d6efd; text-decoration: none; font-size: 14px;">Demote</a> | 
                                            <a href="#" style="color: #dc3545; text-decoration: none; font-size: 14px;">Delete</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div> 
        
    </div> 
</body>
</html>
