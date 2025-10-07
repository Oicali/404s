<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Management - Shannarts</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
   
        @import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700&family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap');
        
       /*puppyy*/
	   
        :root {
            --primary-dark: #8b1538; /* Deep Maroon/Red */
            --primary-light: #f5e4ed; /* Light Pink for hover/background */
            --secondary-text: #6d1029; /* Muted Red for link text */
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
            
            /* Background applied to the whole page */
            background-image: url('<%= request.getContextPath() %>/images/dashbg.png');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-color: #fcfcfc; /* Fallback for browsers */
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

        .content-container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
        }
        
        .header-controls {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
        }

        .header-controls h1 {
            font-family: var(--header-font);
            font-size: 44px;
            color: var(--primary-dark);
            font-weight: 700;
            letter-spacing: 1px;
        }

        .add-product-btn {
            padding: 12px 25px;
            background: var(--primary-dark);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            display: flex;
            align-items: center;
            text-decoration: none;
        }
        
        .add-product-btn i {
            margin-right: 10px;
        }
        
        .add-product-btn:hover {
            background: #6d1029;
        }
        
        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
        }

        .product-card {
            background: #fff;
            border: 1px solid var(--primary-light);
            border-radius: 15px;
            box-shadow: 0 4px 10px var(--subtle-shadow);
            overflow: hidden;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(139, 21, 56, 0.15);
        }

        .product-image-container {
            width: 100%;
      
            padding-top: 75%; 
            position: relative;
            overflow: hidden;
        }
        
        .product-image-container img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover; 
            transition: transform 0.3s ease;
        }
        
        .product-card:hover .product-image-container img {
            transform: scale(1.05);
        }

        .product-info {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .product-name {
            font-family: var(--header-font);
            font-size: 22px;
            font-weight: 700;
            color: var(--secondary-text);
            margin-bottom: 10px;
        }

        .product-price {
            font-size: 20px;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 15px;
        }
        
        .product-actions a {
            display: block;
            width: 100%;
            padding: 10px 15px;
            background: var(--primary-light);
            color: var(--secondary-text);
            text-align: center;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s ease;
        }
        
        .product-actions a:hover {
            background: var(--primary-dark);
            color: white;
        }
        
    
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
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                min-height: 100px;
                padding: 20px;
            }
            
            .main-content-wrapper {
                margin-left: 0;
                padding: 20px;
            }
            
            .content-container {
                padding: 20px;
            }
            
            .header-controls {
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 20px;
            }
            
            .header-controls h1 {
                font-size: 36px;
                margin-bottom: 15px;
            }
            
            .add-product-btn {
                width: 100%;
                justify-content: center;
            }
            
            .product-grid {
                grid-template-columns: 1fr;
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
            <li><a href="products" class="nav-link active"><i class="fas fa-box-open"></i> Products</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-users"></i> Transactions</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

      
        <a href="logout" class="logout-btn">Logout</a>
    </div>


    <div class="main-content-wrapper">
        
        <div class="content-container">
            
            <div class="header-controls">
                <h1>Products Management</h1>
                <a href="add_product.jsp" class="add-product-btn">
                    <i class="fas fa-plus"></i> Add New Product
                </a>
            </div>

   
            <div class="product-grid">
                
            
                <div class="product-card">
                    <div class="product-image-container">
                       
                        <img src="<%= request.getContextPath() %>/images/roses.jpg"alt="Romantic Red Roses Bouquet">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">The Romantic Bouquet</div>
                            <div class="product-price"><span class="currency-symbol">₱</span>3,500.00</div>
                        </div>
                        <div class="product-actions">
                            <a href="edit_product.jsp?id=101"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>

                <div class="product-card">
                    <div class="product-image-container">
                       
                         <img src="<%= request.getContextPath() %>/images/sunflower.jpg" alt="Sunshine Yellow Flower Gift Box">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Sunshine Sunflower Bouquet</div>
                            <div class="product-price"><span class="currency-symbol">₱</span>1,899.00</div>
                        </div>
                        <div class="product-actions">
                            <a href="edit_product.jsp?id=102"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
                
             
                <div class="product-card">
                    <div class="product-image-container">
                      
                      <img src="<%= request.getContextPath() %>/images/tangled.jpg" alt="Purple Flower Basket Arrangement">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Tangled Inspired Bouquet</div>
                            <div class="product-price"><span class="currency-symbol">₱</span>2,950.00</div>
                        </div>
                        <div class="product-actions">
                            <a href="edit_product.jsp?id=103"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>

            
                <div class="product-card">
                    <div class="product-image-container">
                       
                        <img src="<%= request.getContextPath() %>/images/money.jpg" alt="Mini Succulent Plant Collection">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Pretty Big Money Bouquet</div>
                            <div class="product-price"><span class="currency-symbol">₱</span>1,100.00</div>
                        </div>
                        <div class="product-actions">
                            <a href="edit_product.jsp?id=104"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
 
                <div class="product-card">
                    <div class="product-image-container">
                       
                     <img src="<%= request.getContextPath() %>/images/butterfly.jpg"alt="White Lily Condolence Wreath">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Butterfly Bouquet</div>
                            <div class="product-price"><span class="currency-symbol">₱</span>5,400.00</div>
                        </div>
                        <div class="product-actions">
                            <a href="edit_product.jsp?id=105"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
                
            </div> 

        </div> 
        
    </div> 
</body>
</html>
