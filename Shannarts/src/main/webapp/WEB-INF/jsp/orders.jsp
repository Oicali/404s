<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Orders Management - Shannarts</title>
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
            --success: #28a745;
            --pending: #ffc107;
            --shipping: #007bff;
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

        .table-responsive {
            overflow-x: auto;
            margin-top: 20px;
        }
        
        /* --- Table Styling --- */
        .orders-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 17px;
            text-align: left;
        }
        
        .orders-table th, .orders-table td {
            padding: 15px 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .orders-table th {
            font-weight: 700;
            color: var(--secondary-text);
            background-color: var(--primary-light);
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
            cursor: pointer; /* Suggests sorting capability */
        }
        
        .orders-table tr:hover {
            background-color: #fcf4f7;
        }
        
        .view-details-btn {
            padding: 8px 15px;
            background: var(--primary-dark);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .view-details-btn:hover {
            background: #6d1029;
        }
        
        /* --- Status Badges --- */
        .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 5px;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-pending {
            background-color: var(--pending);
            color: #333;
        }
        .status-paid {
            background-color: var(--success);
            color: white;
        }
        .status-shipped {
            background-color: var(--shipping);
            color: white;
        }
        .status-failed {
            background-color: var(--danger);
            color: white;
        }
        
        /* --- MODAL STYLES --- */
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
            width: 95%;
            max-width: 800px; /* Wider modal for details */
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
            position: relative;
            transform: translateY(-50px);
            transition: transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            max-height: 90vh;
            overflow-y: auto;
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
        
        /* --- Detail Sections --- */
        .detail-group {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        
        .detail-item {
            font-size: 18px;
            font-weight: 500;
            color: #333;
        }
        
        .detail-item strong {
            font-weight: 700;
            color: var(--secondary-text);
            margin-right: 5px;
        }
        
        .details-sub-header {
            font-family: var(--header-font);
            font-size: 24px;
            color: var(--primary-dark);
            margin-top: 30px;
            margin-bottom: 15px;
        }
        
        /* --- Itemized Details Table --- */
        .items-table {
            width: 100%;
            border-collapse: collapse;
        }
        
        .items-table th, .items-table td {
            padding: 10px;
            border: 1px solid #f5f5f5;
            text-align: left;
        }
        
        .items-table th {
            background-color: var(--primary-light);
            font-size: 15px;
            font-weight: 700;
            color: var(--secondary-text);
        }
        
        /* --- Status Update Form --- */
        .status-update-section {
            background-color: var(--primary-light);
            padding: 20px;
            border-radius: 10px;
            margin-top: 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .status-update-section label {
            font-weight: 600;
            color: var(--secondary-text);
            font-size: 18px;
            margin-right: 15px;
        }

        .status-update-section select {
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 16px;
            margin-right: 15px;
            flex-grow: 1;
            max-width: 200px;
        }

        .modal-btn-save {
            padding: 10px 20px;
            background: var(--primary-dark);
            color: white;
            border: none;
            border-radius: 6px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.3s;
        }

        .modal-btn-save:hover {
            background: #6d1029;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
                padding: 20px;
            }
            
            .main-content-wrapper {
                margin-left: 0;
                padding: 20px;
            }
            
            .content-container {
                padding: 20px;
            }
            
            .header-controls h1 {
                font-size: 36px;
            }
            
            .orders-table th, .orders-table td {
                padding: 10px 8px;
                font-size: 14px;
            }
            
            /* Stack elements in modal detail group */
            .detail-group {
                flex-direction: column;
            }
            .detail-item {
                margin-bottom: 10px;
            }
            
            .status-update-section {
                flex-direction: column;
                align-items: stretch;
            }
            
            .status-update-section label, .status-update-section select, .modal-btn-save {
                margin-bottom: 10px;
                margin-right: 0;
                width: 100%;
                max-width: none;
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
            <li><a href="orders" class="nav-link active"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-users"></i> Transactions</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

      
        <a href="logout" class="logout-btn">Logout</a>
    </div>


    <div class="main-content-wrapper">
        
        <div class="content-container">
            
            <div class="header-controls">
                <h1>Customer Orders</h1>
            </div>

            <div class="table-responsive">
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer (User ID)</th>
                            <th>Order Date</th>
                            <th>Payment Method</th>
                            <th>Total Amount</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                        <tr class="order-row" 
                            data-txn-id="TXN1001" 
                            data-user-id="U458A" 
                            data-date="2025-10-08 14:30:00" 
                            data-method="GCash" 
                            data-total="3500.00" 
                            data-status="Paid"
                            data-items='[
                                {"name": "The Romantic Bouquet", "unitPrice": 3500.00, "quantity": 1, "subtotal": 3500.00},
                                {"name": "Delivery Fee (Metro)", "unitPrice": 0.00, "quantity": 1, "subtotal": 0.00}
                            ]'>
                            <td>TXN1001</td>
                            <td>U458A</td>
                            <td><fmt:formatDate pattern="MMM dd, yyyy" value="<%= new java.util.Date() %>"/></td>
                            <td>GCash</td>
                            <td>₱3,500.00</td>
                            <td><span class="status-badge status-paid">Paid</span></td>
                            <td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                        </tr>

                        <tr class="order-row" 
                            data-txn-id="TXN1002" 
                            data-user-id="U991B" 
                            data-date="2025-10-07 09:15:00" 
                            data-method="COD" 
                            data-total="4700.00" 
                            data-status="Pending"
                            data-items='[
                                {"name": "Sunshine Sunflower Bouquet", "unitPrice": 1899.00, "quantity": 2, "subtotal": 3798.00},
                                {"name": "Gift Card Add-on", "unitPrice": 100.00, "quantity": 1, "subtotal": 100.00},
                                {"name": "Provincial Delivery", "unitPrice": 802.00, "quantity": 1, "subtotal": 802.00}
                            ]'>
                            <td>TXN1002</td>
                            <td>U991B</td>
                            <td>Oct 07, 2025</td>
                            <td>COD</td>
                            <td>₱4,700.00</td>
                            <td><span class="status-badge status-pending">Pending</span></td>
                            <td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                        </tr>
                        
                         <tr class="order-row" 
                            data-txn-id="TXN1003" 
                            data-user-id="U221D" 
                            data-date="2025-10-06 17:00:00" 
                            data-method="Card" 
                            data-total="5400.00" 
                            data-status="Shipped"
                            data-items='[
                                {"name": "Butterfly Bouquet", "unitPrice": 5400.00, "quantity": 1, "subtotal": 5400.00}
                            ]'>
                            <td>TXN1003</td>
                            <td>U221D</td>
                            <td>Oct 06, 2025</td>
                            <td>Card</td>
                            <td>₱5,400.00</td>
                            <td><span class="status-badge status-shipped">Shipped</span></td>
                            <td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                        </tr>
                        
                         <tr class="order-row" 
                            data-txn-id="TXN1004" 
                            data-user-id="U600E" 
                            data-date="2025-10-05 11:45:00" 
                            data-method="PayPal" 
                            data-total="1100.00" 
                            data-status="Failed"
                            data-items='[
                                {"name": "Pretty Big Money Bouquet", "unitPrice": 1100.00, "quantity": 1, "subtotal": 1100.00}
                            ]'>
                            <td>TXN1004</td>
                            <td>U600E</td>
                            <td>Oct 05, 2025</td>
                            <td>PayPal</td>
                            <td>₱1,100.00</td>
                            <td><span class="status-badge status-failed">Failed</span></td>
                            <td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                        </tr>
                        
                    </tbody>
                </table>
            </div>

        </div> 
        
    </div> 
    
    
    <div id="orderDetailsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modal-order-title">Order Details: TXNXXXX</h2>
                <button class="close-btn" data-modal-close>&times;</button>
            </div>
            
            <div class="detail-group">
                <div class="detail-item"><strong>Customer ID:</strong> <span id="modal-user-id"></span></div>
                <div class="detail-item"><strong>Order Date:</strong> <span id="modal-date"></span></div>
                <div class="detail-item"><strong>Payment Method:</strong> <span id="modal-method"></span></div>
            </div>
            
            <h3 class="details-sub-header">Itemized Products</h3>
            
            <div class="table-responsive">
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Product/Service</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody id="modal-items-tbody">
                        </tbody>
                </table>
            </div>
            
            <div class="detail-group" style="border-top: 2px solid var(--primary-dark); margin-top: 20px; padding-top: 15px;">
                <div class="detail-item" style="font-size: 22px;"><strong>GRAND TOTAL:</strong> <span id="modal-total" style="color: var(--danger); font-size: 24px;"></span></div>
            </div>

            <h3 class="details-sub-header">Update Status</h3>
            
            <form id="status-update-form" action="updateOrderStatusServlet" method="POST">
                <input type="hidden" name="transaction_id" id="update-txn-id">
                
                <div class="status-update-section">
                    <label for="update-status-select"><i class="fas fa-sync-alt"></i> Change Status:</label>
                    
                    <select id="update-status-select" name="payment_status">
                        <option value="Pending">Pending</option>
                        <option value="Paid">Paid</option>
                        <option value="Shipped">Shipped</option>
                        <option value="Delivered">Delivered</option>
                        <option value="Failed">Failed</option>
                    </select>
                    
                    <button type="submit" class="modal-btn-save"><i class="fas fa-check"></i> Save Status</button>
                </div>
            </form>
            
        </div>
    </div>
    
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const modal = document.getElementById('orderDetailsModal');
            const closeButtons = document.querySelectorAll('[data-modal-close]');
            const detailButtons = document.querySelectorAll('.view-details-btn');
            
            // Modal elements
            const modalTitle = document.getElementById('modal-order-title');
            const modalUserId = document.getElementById('modal-user-id');
            const modalDate = document.getElementById('modal-date');
            const modalMethod = document.getElementById('modal-method');
            const modalTotal = document.getElementById('modal-total');
            const modalItemsTbody = document.getElementById('modal-items-tbody');
            const updateTxnId = document.getElementById('update-txn-id');
            const updateStatusSelect = document.getElementById('update-status-select');

            // Function to handle the actual currency formatting
            function formatCurrency(amount) {
                 return `₱\${parseFloat(amount).toLocaleString('en-US', { minimumFractionDigits: 2 })}`;
            }


            // --- Modal Open/Close Logic ---

            function openModal() {
                modal.classList.add('is-active');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                modal.classList.remove('is-active');
                document.body.style.overflow = 'auto';
            }

            closeButtons.forEach(button => {
                button.addEventListener('click', closeModal);
            });

            window.addEventListener('click', (event) => {
                if (event.target === modal) {
                    closeModal();
                }
            });

            // --- Populate and Open Modal ---

            detailButtons.forEach(button => {
                button.addEventListener('click', (event) => {
                    const row = event.target.closest('.order-row');
                    if (!row) return;

                    // 1. Retrieve data
                    const txnId = row.getAttribute('data-txn-id');
                    const userId = row.getAttribute('data-user-id');
                    const date = row.getAttribute('data-date');
                    const method = row.getAttribute('data-method');
                    const total = row.getAttribute('data-total');
                    const status = row.getAttribute('data-status');
                    const itemsJson = row.getAttribute('data-items');
                    
                    // Parse the itemized details
                    const items = JSON.parse(itemsJson); 

                    // 2. Populate Header and Summary
                    modalTitle.textContent = `Order Details: ${txnId}`;
                    modalUserId.textContent = userId;
                    modalDate.textContent = new Date(date).toLocaleDateString(); // Format date nicely
                    modalMethod.textContent = method;
                    // FIX: Escape $ in template literal
                    modalTotal.textContent = formatCurrency(total);
                    
                    // 3. Populate Items Table
                    modalItemsTbody.innerHTML = ''; // Clear previous items
                    items.forEach(item => {
                        const tr = document.createElement('tr');
                        // FIX: Escape $ in template literals here by adding a backslash: \${
                        tr.innerHTML = `
                            <td>\${item.name}</td>
                            <td>\${formatCurrency(item.unitPrice)}</td>
                            <td>\${item.quantity}</td>
                            <td>\${formatCurrency(item.subtotal)}</td>
                        `;
                        modalItemsTbody.appendChild(tr);
                    });
                    
                    // 4. Populate Status Update Form
                    updateTxnId.value = txnId;
                    updateStatusSelect.value = status; 
                    
                    // 5. Open Modal
                    openModal();
                });
            });
            
        });
    </script>
</body>
</html>