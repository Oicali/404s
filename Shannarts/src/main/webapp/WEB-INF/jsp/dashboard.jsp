<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Shannarts</title>
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
            flex-shrink: 0; /* Prevent squishing */
            
         
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
			    margin-left: 0; /* or even negative if you want it closer */
			
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
            transform: scale(1.02); /* Subtle hover effect */
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
        
 
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: #fff; 
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px var(--subtle-shadow);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-left: 5px solid var(--primary-dark); 
            min-height: 130px;
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(139, 21, 56, 0.15);
        }

        .stat-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
        }
        
        .stat-value {
            font-size: 32px;
            color: var(--primary-dark);
            font-weight: 700;
        }
        
        .stat-label {
            font-size: 16px;
            color: #777;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .currency-symbol {
            font-family: sans-serif; 
            color: #10b981;
        }

        .stat-icon-large {
            font-size: 36px;
            color: #ccc;
            opacity: 0.6;
        }
        
        
        .stat-icon-large.customers i { color: #d63384; }
        .stat-icon-large.orders i { color: #0dcaf0; }
        .stat-icon-large.products i { color: #6f42c1; }
        .stat-icon-large.earnings span { color: #198754; }

      
        .dashboard-content-grid {
            display: grid;
            grid-template-columns: 1fr; 
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
        

        .orders-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 16px;
        }

        .orders-table th, .orders-table td {
            padding: 15px;
            border-bottom: 1px solid #eee;
        }

        .orders-table th {
            background-color: var(--primary-light);
            color: var(--secondary-text);
            font-weight: 600;
            text-transform: uppercase;
            font-size: 14px;
        }

        .orders-table tbody tr:hover {
            background-color: #fcfcfc;
        }
        
        .status-badge {
            padding: 5px 10px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
        }
        
        .status-badge.pending { background-color: #fff3cd; color: #ffc107; }
        .status-badge.shipped { background-color: #d1e7dd; color: #198754; }
        .status-badge.delivered { background-color: #cfe2ff; color: #0d6efd; }

        @media (max-width: 1024px) {
            .main-content-wrapper {
                margin-left: 250px;
                padding: 30px;
            }
            .sidebar {
                width: 250px;
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
            
            .orders-table th, .orders-table td {
                padding: 10px;
            }
            .orders-table th:nth-child(3), .orders-table td:nth-child(3) {
                display: none; 
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
            <li><a href="dashboard" class="nav-link active"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            <li><a href="products" class="nav-link"><i class="fas fa-box-open"></i> Products</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-users"></i> Transactions</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

     
        <a href="logout" class="logout-btn">Logout</a>
    </div>

 
    <div class="main-content-wrapper">
        
        <div class="dashboard-container">
            
            <div class="welcome-header">
                <h1>Dashboard</h1>
                <p>Welcome back, Admin! Here's a summary of your shop's activity.</p>
            </div>

           
            <div class="stats-grid">
                
               
                <div class="stat-card">
                    <div class="stat-top">
                        <div class="stat-value">89</div>
                        <div class="stat-icon-large customers"><i class="fas fa-users"></i></div>
                    </div>
                    <div class="stat-label">Total Customers</div>
                </div>

                
                <div class="stat-card">
                    <div class="stat-top">
                        <div class="stat-value">152</div>
                        <div class="stat-icon-large orders"><i class="fas fa-shopping-cart"></i></div>
                    </div>
                    <div class="stat-label">Total Orders</div>
                </div>

              
                <div class="stat-card">
                    <div class="stat-top">
                        <div class="stat-value">45</div>
                        <div class="stat-icon-large products"><i class="fas fa-box"></i></div>
                    </div>
                    <div class="stat-label">Total Products</div>
                </div>
                
                
                <div class="stat-card">
                    <div class="stat-top">
                        <div class="stat-value"><span class="currency-symbol">₱</span>12,830</div>
                        <div class="stat-icon-large earnings"><i class="fas fa-chart-bar"></i></div>
                    </div>
                    <div class="stat-label">Total Earnings</div>
                </div>

            </div>
            
            
            <div class="dashboard-content-grid">
                
             
                <div class="section-card">
                    <h2>Recent Orders</h2>
                    <table class="orders-table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th class="hide-on-mobile">Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>#9001</td>
                                <td>Jane D.</td>
                                <td class="hide-on-mobile">Oct 05, 2025</td>
                                <td>₱1,250</td>
                                <td><span class="status-badge shipped">Shipped</span></td>
                            </tr>
                            <tr>
                                <td>#9002</td>
                                <td>Ryan T.</td>
                                <td class="hide-on-mobile">Oct 04, 2025</td>
                                <td>₱4,800</td>
                                <td><span class="status-badge delivered">Delivered</span></td>
                            </tr>
                            <tr>
                                <td>#9003</td>
                                <td>Sophia L.</td>
                                <td class="hide-on-mobile">Oct 04, 2025</td>
                                <td>₱550</td>
                                <td><span class="status-badge pending">Pending</span></td>
                            </tr>
                            <tr>
                                <td>#9004</td>
                                <td>Michael K.</td>
                                <td class="hide-on-mobile">Oct 03, 2025</td>
                                <td>₱9,100</td>
                                <td><span class="status-badge delivered">Delivered</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        </div> 
        
    </div> 
</body>
</html>