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
        
       /* Style Variables */
	   
        :root {
            --primary-dark: #8b1538; /* Deep Maroon/Red */
            --primary-light: #f5e4ed; /* Light Pink for hover/background */
            --secondary-text: #6d1029; /* Muted Red for link text */
            --subtle-shadow: rgba(0, 0, 0, 0.15);
            --header-font: 'Cinzel Decorative', cursive;
            --body-font: 'Cormorant Garamond', serif;
            --danger: #dc3545;
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
            /* ... (Sidebar styles retained) ... */
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
            transition: background 0.3s ease, transform 0.2s;
            display: flex;
            align-items: center;
            text-decoration: none;
        }
        
        .add-product-btn i {
            margin-right: 10px;
        }
        
        .add-product-btn:hover {
            background: #6d1029;
            transform: translateY(-2px);
        }
        
        /* Product Grid: UPDATED for 4 columns */
        .product-grid {
            display: grid;
            /* Changed minmax to 220px to allow 4 columns comfortably */
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); 
            gap: 25px; /* Slightly tighter gap for 4 columns */
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
            padding: 15px; /* Reduced padding slightly for compactness */
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-name {
            font-family: var(--header-font);
            font-size: 20px; /* Slightly smaller font for compactness */
            font-weight: 700;
            color: var(--secondary-text);
            margin-bottom: 5px;
        }
        
        .product-description {
            font-size: 14px; /* Smaller font for snippet */
            color: #666;
            margin-bottom: 10px;
            font-style: italic;
            /* Keep max-height for a neat snippet */
            max-height: 3.2em; 
            overflow: hidden; 
            text-overflow: ellipsis; 
        }

        .product-price {
            font-size: 18px; /* Slightly smaller font for compactness */
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 15px;
            margin-top: auto; 
        }
        
        .product-actions a {
            display: block;
            width: 100%;
            padding: 8px 10px; /* Reduced padding */
            background: var(--primary-light);
            color: var(--secondary-text);
            text-align: center;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s ease;
            cursor: pointer;
            font-size: 15px;
        }
        
        .product-actions a:hover {
            background: var(--primary-dark);
            color: white;
        }
        
    
        @media (max-width: 1200px) {
            .product-grid {
                /* Go down to 3 columns on medium screens */
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
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
            
            /* Go down to 2 columns on small screens */
            .product-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            }
        }

        /* --- MODAL STYLES (No change needed here, the textarea will naturally show the full description) --- */
        .modal {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            display: none; 
            justify-content: center;
            align-items: center;
            z-index: 2000;
            opacity: 0;
            transition: opacity 0.3s ease-in-out;
            backdrop-filter: blur(4px);
        }

        .modal.is-active {
            display: flex;
            opacity: 1;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 650px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            position: relative;
            transform: translateY(-50px);
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        .modal.is-active .modal-content {
            transform: translateY(0);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--primary-dark);
            padding-bottom: 15px;
            margin-bottom: 20px;
        }

        .modal-header h2 {
            font-family: var(--header-font);
            color: var(--primary-dark);
            font-size: 32px;
        }

        .close-btn {
            background: none;
            border: none;
            font-size: 28px;
            color: var(--secondary-text);
            cursor: pointer;
            transition: color 0.2s;
        }

        .close-btn:hover {
            color: var(--danger);
            transform: rotate(90deg);
        }
        
        /* Form Styling */
        .modal-form label {
            display: block;
            font-weight: 600;
            color: var(--secondary-text);
            margin-top: 15px;
            margin-bottom: 5px;
            font-size: 18px;
        }

        .modal-form input[type="text"],
        .modal-form input[type="number"],
        .modal-form textarea {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
            font-family: var(--body-font);
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        
        .modal-form textarea {
            resize: vertical;
            min-height: 100px;
            /* Ensure text area shows full content when opened */
        }

        .modal-form input:focus, .modal-form textarea:focus {
            outline: none;
            border-color: var(--primary-dark);
            box-shadow: 0 0 5px rgba(139, 21, 56, 0.4);
        }
        
        .image-upload-area {
            display: flex;
            gap: 20px;
            align-items: center;
            margin-bottom: 20px;
            padding: 15px;
            border: 2px dashed var(--primary-light);
            border-radius: 10px;
            background: #fffafa;
        }

        .current-image-preview {
            display: block;
            width: 120px;
            height: 120px;
            border-radius: 10px;
            object-fit: cover;
            border: 3px solid var(--primary-dark);
            flex-shrink: 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .image-upload-controls {
            flex-grow: 1;
        }
        
        .image-upload-controls p {
            font-size: 14px;
            color: #888;
            margin-top: 5px;
        }

        .form-actions {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eee;
            padding-top: 20px;
        }

        .modal-btn {
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .modal-btn-save {
            background: var(--primary-dark);
            color: white;
        }

        .modal-btn-save:hover {
            background: #6d1029;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(139, 21, 56, 0.4);
        }
        
        .modal-btn-cancel {
            background: #ccc;
            color: #333;
        }
        
        .modal-btn-cancel:hover {
            background: #bbb;
        }
        
        .modal-btn-delete {
            background: var(--danger);
            color: white;
        }
        
        .modal-btn-delete:hover {
            background: #a91a27;
            transform: translateY(-2px);
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
            <li><a href="orders" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="transactions" class="nav-link"><i class="fas fa-users"></i> Transactions</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

      
        <a href="logout" class="logout-btn">Logout</a>
    </div>


    <div class="main-content-wrapper">
        
        <div class="content-container">
            
            <div class="header-controls">
                <h1>Products Management</h1>
                <a class="add-product-btn" id="open-add-modal">
                    <i class="fas fa-plus"></i> Add New Product
                </a>
            </div>

   
            <div class="product-grid">
                
                <div class="product-card" data-id="101" data-name="The Romantic Bouquet" data-price="3500.00" data-path="<%= request.getContextPath() %>/images/roses.jpg" data-desc="A classic arrangement of premium red roses, perfect for expressing deep love and passion. Each rose is hand-selected for quality and vibrant color.">
                    <div class="product-image-container">
                        <img src="<%= request.getContextPath() %>/images/roses.jpg" alt="Romantic Red Roses Bouquet">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">The Romantic Bouquet</div>
                            <div class="product-description">A classic arrangement of premium red roses, perfect for expressing deep love and passion...</div>
                        </div>
                        <div class="product-price"><span class="currency-symbol">₱</span>3,500.00</div>
                        <div class="product-actions">
                            <a class="manage-product-btn"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>

                <div class="product-card" data-id="102" data-name="Sunshine Sunflower Bouquet" data-price="1899.00" data-path="<%= request.getContextPath() %>/images/sunflower.jpg" data-desc="Bright and cheerful sunflowers wrapped in elegant paper, bringing joy to any occasion. The perfect gift to brighten someone's day.">
                    <div class="product-image-container">
                         <img src="<%= request.getContextPath() %>/images/sunflower.jpg" alt="Sunshine Yellow Flower Gift Box">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Sunshine Sunflower Bouquet</div>
                            <div class="product-description">Bright and cheerful sunflowers wrapped in elegant paper...</div>
                        </div>
                        <div class="product-price"><span class="currency-symbol">₱</span>1,899.00</div>
                        <div class="product-actions">
                            <a class="manage-product-btn"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
                
             
                <div class="product-card" data-id="103" data-name="Tangled Inspired Bouquet" data-price="2950.00" data-path="<%= request.getContextPath() %>/images/tangled.jpg" data-desc="Purple and lavender blooms creating a whimsical, fairytale look inspired by the movie Tangled. Features a mix of imported and local flowers.">
                    <div class="product-image-container">
                      <img src="<%= request.getContextPath() %>/images/tangled.jpg" alt="Purple Flower Basket Arrangement">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Tangled Inspired Bouquet</div>
                            <div class="product-description">Purple and lavender blooms creating a whimsical, fairytale look...</div>
                        </div>
                        <div class="product-price"><span class="currency-symbol">₱</span>2,950.00</div>
                        <div class="product-actions">
                            <a class="manage-product-btn"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>

            
                <div class="product-card" data-id="104" data-name="Pretty Big Money Bouquet" data-price="1100.00" data-path="<%= request.getContextPath() %>/images/money.jpg" data-desc="A fun and festive bouquet made with actual crisp bank notes, perfect for gifts on birthdays or graduations. Note values must be provided by the customer.">
                    <div class="product-image-container">
                        <img src="<%= request.getContextPath() %>/images/money.jpg" alt="Mini Succulent Plant Collection">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Pretty Big Money Bouquet</div>
                            <div class="product-description">A fun and festive bouquet made with actual crisp bank notes...</div>
                        </div>
                        <div class="product-price"><span class="currency-symbol">₱</span>1,100.00</div>
                        <div class="product-actions">
                            <a class="manage-product-btn"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
 
                <div class="product-card" data-id="105" data-name="Butterfly Bouquet" data-price="5400.00" data-path="<%= request.getContextPath() %>/images/butterfly.jpg" data-desc="An elegant mix of flowers adorned with delicate butterfly accents, a truly magical gift for a special anniversary or milestone.">
                    <div class="product-image-container">
                     <img src="<%= request.getContextPath() %>/images/butterfly.jpg" alt="White Lily Condolence Wreath">
                    </div>
                    <div class="product-info">
                        <div>
                            <div class="product-name">Butterfly Bouquet</div>
                            <div class="product-description">An elegant mix of flowers adorned with delicate butterfly accents...</div>
                        </div>
                        <div class="product-price"><span class="currency-symbol">₱</span>5,400.00</div>
                        <div class="product-actions">
                            <a class="manage-product-btn"><i class="fas fa-edit"></i> Manage Product</a>
                        </div>
                    </div>
                </div>
                
            </div> 

        </div> 
        
    </div> 
    
    
    <div id="updateProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="update-modal-title">Update Product</h2>
                <button class="close-btn" data-modal-close>&times;</button>
            </div>
            <form id="update-product-form" class="modal-form" action="updateProductServlet" method="POST" enctype="multipart/form-data">
                
                <input type="hidden" name="product_id" id="update-product-id">

                <label for="update-product-name">Bouquet Name (<span style="color:red">*</span>)</label>
                <input type="text" id="update-product-name" name="product_name" required>
                
                <label for="update-product-description">Description</label>
                <textarea id="update-product-description" name="description" rows="5"></textarea> 

                <label for="update-product-price">Price (₱) (<span style="color:red">*</span>)</label>
                <input type="number" id="update-product-price" name="price" step="0.01" min="0" required>
                
                <label>Image Management</label>
                <div class="image-upload-area">
                    <img id="current-image-preview" class="current-image-preview" alt="Current Product Image">
                    <div class="image-upload-controls">
                        <label for="update-product-image">Change Image</label>
                        <input type="file" id="update-product-image" name="image_path" accept="image/*">
                        <p>Upload a new image to replace the current one. Max size: 5MB.</p>
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="modal-btn modal-btn-delete" id="delete-product-btn"><i class="fas fa-trash"></i> Delete Product</button>
                    <div>
                         <button type="button" class="modal-btn modal-btn-cancel" data-modal-close>Cancel</button>
                        <button type="submit" class="modal-btn modal-btn-save"><i class="fas fa-save"></i> Save Changes</button>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div id="addProductModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Product</h2>
                <button class="close-btn" data-modal-close>&times;</button>
            </div>
            <form id="add-product-form" class="modal-form" action="addProductServlet" method="POST" enctype="multipart/form-data">
                
                <label for="add-product-name">Bouquet Name (<span style="color:red">*</span>)</label>
                <input type="text" id="add-product-name" name="product_name" required>
                
                <label for="add-product-description">Description</label>
                <textarea id="add-product-description" name="description" rows="5" placeholder="A brief description of the bouquet."></textarea>

                <label for="add-product-price">Price (₱) (<span style="color:red">*</span>)</label>
                <input type="number" id="add-product-price" name="price" step="0.01" min="0" required>

                <label for="add-product-image">Upload Image (<span style="color:red">*</span>)</label>
                <input type="file" id="add-product-image" name="image_path" accept="image/*" required>
                
                <div class="form-actions">
                    <button type="button" class="modal-btn modal-btn-cancel" data-modal-close>Cancel</button>
                    <button type="submit" class="modal-btn modal-btn-save"><i class="fas fa-plus"></i> Add Product</button>
                </div>
            </form>
        </div>
    </div>
    
    <form id="delete-product-form" action="deleteProductServlet" method="POST">
        <input type="hidden" name="product_id" id="delete-product-id-input">
    </form>
    
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const updateModal = document.getElementById('updateProductModal');
            const addModal = document.getElementById('addProductModal');
            const closeButtons = document.querySelectorAll('[data-modal-close]');
            const manageButtons = document.querySelectorAll('.manage-product-btn');
            const addProductButton = document.getElementById('open-add-modal');
            const deleteProductBtn = document.getElementById('delete-product-btn');
            const deleteForm = document.getElementById('delete-product-form');

            // --- Modal Open/Close Logic ---

            function openModal(modal) {
                modal.classList.add('is-active');
                document.body.style.overflow = 'hidden';
            }

            function closeModal(modal) {
                modal.classList.remove('is-active');
                document.body.style.overflow = 'auto';
            }

            closeButtons.forEach(button => {
                button.addEventListener('click', () => {
                    closeModal(updateModal);
                    closeModal(addModal);
                });
            });

            window.addEventListener('click', (event) => {
                if (event.target === updateModal) {
                    closeModal(updateModal);
                }
                if (event.target === addModal) {
                    closeModal(addModal);
                }
            });


            // --- Add Product Functionality ---

            addProductButton.addEventListener('click', () => {
                document.getElementById('add-product-form').reset();
                openModal(addModal);
            });
            

            // --- Manage (Update) Product Functionality ---

            manageButtons.forEach(button => {
                button.addEventListener('click', (event) => {
                    const card = event.target.closest('.product-card');
                    if (!card) return;

                    const id = card.getAttribute('data-id');
                    const name = card.getAttribute('data-name');
                    const price = card.getAttribute('data-price');
                    const imagePath = card.getAttribute('data-path');
                    
                    // Crucial: Get the FULL description from the data attribute
                    const description = card.getAttribute('data-desc'); 

                    // 1. Populate the form fields in the Update Modal
                    document.getElementById('update-modal-title').textContent = `Update ${name}`;
                    document.getElementById('update-product-id').value = id;
                    document.getElementById('update-product-name').value = name;
                    document.getElementById('update-product-price').value = parseFloat(price).toFixed(2);
                    
                    // Populate the textarea with the full description
                    document.getElementById('update-product-description').value = description; 
                    
                    document.getElementById('current-image-preview').src = imagePath;
                    
                    // Clear the file input
                    document.getElementById('update-product-image').value = ''; 
                    
                    // 2. Open the Update Modal
                    openModal(updateModal);
                });
            });
            
            // --- Delete Product Functionality ---
            deleteProductBtn.addEventListener('click', () => {
                const productId = document.getElementById('update-product-id').value;
                const productName = document.getElementById('update-product-name').value;
                
                if (confirm(`Are you sure you want to permanently DELETE the product: "${productName}" (ID: ${productId})? This action cannot be undone.`)) {
                    document.getElementById('delete-product-id-input').value = productId;
                    deleteForm.submit();
                }
            });
            
            // IMPORTANT: File Input Preview 
            document.getElementById('update-product-image').onchange = function (e) {
                if (e.target.files && e.target.files[0]) {
                    document.getElementById('current-image-preview').src = URL.createObjectURL(e.target.files[0]);
                }
            }
            
        });
    </script>
</body>
</html>