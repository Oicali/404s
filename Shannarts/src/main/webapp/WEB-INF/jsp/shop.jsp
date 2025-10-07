<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shannarts Store - Handcrafted Gifts</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Cinzel+Decorative:wght@400;700&family=Cormorant+Garamond:wght@300;400;500;600;700&display=swap');
        
        :root {
            --primary-color: #8b1538; /* Burgundy/Pink */
            --secondary-color: #f7f0f3; /* Light Pink Background */
            --text-color: #333;
            --light-text: #666;
            --cinzel: 'Cinzel Decorative', cursive;
            --cormorant: 'Cormorant Garamond', serif;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: var(--cormorant);
            color: var(--text-color);
            background-color: #fff;
            line-height: 1.6;

			           background-image: url('<%= request.getContextPath() %>/images/dashbg.png');
			           background-size: cover;
			           background-position: center;
			           background-repeat: no-repeat;
			           background-attachment: fixed;
        }

        /* --- Header/Navbar --- */
        .header {
            background-color: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .navbar {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
        }

        .logo-section {
            display: flex;
            align-items: center;
        }

        .brand-name {
            font-family: var(--cinzel);
            font-size: 28px;
            font-weight: 700;
            color: var(--primary-color);
            letter-spacing: 1px;
            margin-left: 10px;
        }
        
        .logo-img {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .nav-links a {
            color: var(--text-color);
            text-decoration: none;
            font-size: 17px;
            font-weight: 600;
            margin: 0 15px;
            padding: 5px 0;
            transition: color 0.3s ease, border-bottom 0.3s ease;
            position: relative;
        }
        
        .nav-links a:hover {
            color: var(--primary-color);
        }
        
        .nav-links a.active::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 100%;
            height: 2px;
            background-color: var(--primary-color);
        }

        .nav-icons {
            display: flex;
            gap: 20px;
            align-items: center;
        }

        .nav-icons a {
            color: var(--text-color);
            font-size: 20px;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        .nav-icons a:hover {
            color: var(--primary-color);
            transform: scale(1.1);
        }
        
        .user-greeting {
            font-size: 16px;
            font-weight: 500;
            margin-right: 15px;
            color: var(--light-text);
        }
        
        .user-greeting span {
            color: var(--primary-color);
            font-weight: 700;
        }

        /* --- Main Content --- */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px 30px;
        }

        /* --- Hero Banner --- */
        .hero {
            background-color: var(--secondary-color);
            padding: 60px 40px;
            margin-bottom: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }

        .hero h1 {
            font-family: var(--cinzel);
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 15px;
            font-weight: 700;
        }

        .hero p {
            font-size: 20px;
            color: var(--light-text);
            max-width: 700px;
            margin: 0 auto 30px;
        }

        .shop-now-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(139, 21, 56, 0.3);
            text-decoration: none;
            display: inline-block;
        }

        .shop-now-btn:hover {
            background-color: #6d1029;
            transform: translateY(-2px);
        }

        /* --- Product Grid --- */
        .section-title {
            font-family: var(--cinzel);
            font-size: 32px;
            color: var(--primary-color);
            text-align: center;
            margin-bottom: 40px;
            font-weight: 700;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            display: block;
            width: 80px;
            height: 3px;
            background: var(--primary-color);
            margin: 10px auto 0;
            border-radius: 2px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            padding-bottom: 60px;
        }

        .product-card {
            background-color: white;
            border: 1px solid #f0f0f0;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-align: center;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .product-image {
            width: 100%;
            height: 250px;
            background-color: var(--secondary-color);
            /* Placeholder for image URL */
            background-image: url("https://placehold.co/300x250/f0d5e0/8b1538?text=Shannarts+Product");
            background-size: cover;
            background-position: center;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .product-image.romantic {
            background-image: url("https://placehold.co/300x250/e0b1bd/8b1538?text=Romantic+Bouquet");
        }
        .product-image.sunshine {
            background-image: url("https://placehold.co/300x250/f7e0a8/8b1538?text=Sunshine+Box");
        }
        .product-image.butterfly {
            background-image: url("https://placehold.co/300x250/c09dd3/8b1538?text=Butterfly+Art");
        }
        .product-image.money {
            background-image: url("https://placehold.co/300x250/b0e0c0/8b1538?text=Money+Bouquet");
        }

        .product-info {
            padding: 20px;
        }

        .product-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--primary-color);
        }

        .product-category {
            font-size: 14px;
            color: var(--light-text);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .product-price {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-color);
            margin-bottom: 15px;
        }

        .add-to-cart-btn {
            background-color: var(--primary-color);
            color: white;
            padding: 10px 25px;
            border: none;
            border-radius: 20px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .add-to-cart-btn:hover {
            background-color: #6d1029;
            transform: translateY(-1px);
        }

        /* --- Footer --- */
        .footer {
            background-color: var(--text-color);
            color: white;
            text-align: center;
            padding: 25px 0;
            font-size: 14px;
        }
        
        .footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        
        .footer a:hover {
            color: var(--primary-color);
        }

        /* --- Responsive Design --- */
        @media (max-width: 992px) {
            .navbar {
                padding: 15px 20px;
            }
            .nav-links {
                display: none; /* Hide navigation links on smaller screens */
            }
            .hero h1 {
                font-size: 36px;
            }
            .hero p {
                font-size: 17px;
            }
            .product-grid {
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            }
        }

        @media (max-width: 576px) {
            .navbar {
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
            }
            .nav-icons {
                margin-top: 10px;
                gap: 15px;
            }
            .brand-name {
                font-size: 24px;
            }
            .hero {
                padding: 40px 20px;
            }
            .hero h1 {
                font-size: 30px;
            }
            .product-grid {
                grid-template-columns: 1fr;
            }
            .container {
                padding: 15px;
            }
            .user-greeting {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="navbar">
            <div class="logo-section">
                <!-- Using a simple icon as a temporary logo placeholder -->
                <i class="fas fa-heart" style="font-size: 28px; color: var(--primary-color);"></i>
                <div class="brand-name">SHANNARTS</div>
            </div>
            
            <nav class="nav-links">
                <a href="shop" class="active">Shop</a>
                <a href="#">New Arrivals</a>
                <a href="#">Custom Order</a>
                <a href="#">Contact</a>
            </nav>

            <div class="nav-icons">
                <c:if test="${loggedUser != null}">
                    <span class="user-greeting">Hello, <span>${loggedUser.firstname}!</span></span>
                </c:if>
                <a href="#"><i class="fas fa-search"></i></a>
                <a href="#"><i class="fas fa-shopping-cart"></i></a>
                <a href="logout" title="Logout"><i class="fas fa-sign-out-alt"></i></a>
            </div>
        </div>
    </header>

    <main class="container">
        <section class="hero">
            <h1>Find the Perfect Handcrafted Gift</h1>
            <p>From custom bouquets to personalized decor, every piece is made with dedication, ensuring your gift is as unique as your loved one.</p>
            <a href="#products" class="shop-now-btn">Explore Collection <i class="fas fa-arrow-right"></i></a>
        </section>

        <section id="products">
            <h2 class="section-title">Our Best Selling Products</h2>

            <div class="product-grid">
                
                <!-- Mock Product Card 1: Romantic Bouquet -->
                <div class="product-card">
                    <div class="product-image romantic"></div>
                    <div class="product-info">
                        <div class="product-category">Bouquets</div>
                        <div class="product-title">The Romantic Bouquet</div>
                        <div class="product-price">₱ 3,500.00</div>
                        <button class="add-to-cart-btn">Add to Cart</button>
                    </div>
                </div>

                <!-- Mock Product Card 2: Sunshine Box -->
                <div class="product-card">
                    <div class="product-image sunshine"></div>
                    <div class="product-info">
                        <div class="product-category">Gift Boxes</div>
                        <div class="product-title">Sunshine Cheer Box</div>
                        <div class="product-price">₱ 1,899.00</div>
                        <button class="add-to-cart-btn">Add to Cart</button>
                    </div>
                </div>

                <!-- Mock Product Card 3: Butterfly Art -->
                <div class="product-card">
                    <div class="product-image butterfly"></div>
                    <div class="product-info">
                        <div class="product-category">Decorations</div>
                        <div class="product-title">Custom Butterfly Frame</div>
                        <div class="product-price">₱ 5,400.00</div>
                        <button class="add-to-cart-btn">Add to Cart</button>
                    </div>
                </div>

                <!-- Mock Product Card 4: Money Bouquet -->
                <div class="product-card">
                    <div class="product-image money"></div>
                    <div class="product-info">
                        <div class="product-category">Novelty Gifts</div>
                        <div class="product-title">Premium Money Bouquet</div>
                        <div class="product-price">₱ 1,100.00</div>
                        <button class="add-to-cart-btn">Add to Cart</button>
                    </div>
                </div>
                
            </div>
        </section>
    </main>

    <footer class="footer">
        <p>&copy; 2025 Shannarts. All rights reserved. | 
            <a href="#">Privacy Policy</a> | 
            <a href="#">Terms of Service</a>
        </p>
    </footer>
</body>
</html>
