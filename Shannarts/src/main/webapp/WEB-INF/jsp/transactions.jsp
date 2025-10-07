<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transactions History - Shannarts</title>
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
            --delivered: #008080; /* Teal/Muted Blue for Delivered */
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
        .transactions-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 17px;
            text-align: left;
        }
        
        .transactions-table th, .transactions-table td {
            padding: 15px 12px;
            border-bottom: 1px solid #eee;
            vertical-align: middle;
        }
        
        .transactions-table th {
            font-weight: 700;
            color: var(--secondary-text);
            background-color: var(--primary-light);
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }
        
        .transactions-table tr:hover {
            background-color: #fcf4f7;
        }
        
        .view-details-btn {
            padding: 8px 15px;
            background: var(--shipping); /* Blue for viewing history/details */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        
        .view-details-btn:hover {
            background: #0056b3;
        }
        
        /* --- Status Badges (Reused from Orders) --- */
        .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 5px;
            font-weight: 700;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-Pending { /* Matches DB enum 'Pending' */
            background-color: var(--pending);
            color: #333;
        }
        .status-Shipped { /* Matches DB enum 'Shipped' */
            background-color: var(--shipping);
            color: white;
        }
        .status-Delivered { /* Matches DB enum 'Delivered' */
            background-color: var(--delivered);
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
            max-width: 800px; 
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
            
            .transactions-table th, .transactions-table td {
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
        }
        
    </style>
</head>
<body>

   
    <div class="sidebar">      
        <div class="logo-container">
            <div class="logo-wrapper">
                <!-- Using a placeholder for your logo -->
                <img src="<%= request.getContextPath() %>/images/1.png" alt="Shannarts Logo" />
            </div>
            <div class="brand-name">SHANNARTS</div>
        </div>

       
        <ul class="nav-links">
            <li><a href="dashboard" class="nav-link"><i class="fas fa-chart-line"></i> Dashboard</a></li>
            <li><a href="products" class="nav-link"><i class="fas fa-box-open"></i> Products</a></li>
            <li><a href="orders" class="nav-link"><i class="fas fa-shopping-cart"></i> Orders</a></li>
            <li><a href="transactions" class="nav-link active"><i class="fas fa-users"></i> Transactions</a></li>
            <li><a href="#" class="nav-link"><i class="fas fa-cog"></i> Settings</a></li>
        </ul>

      
        <a href="logout" class="logout-btn">Logout</a>
    </div>


    <div class="main-content-wrapper">
        
        <div class="content-container">
            
            <div class="header-controls">
                <h1>Transaction History</h1>
            </div>

            <div class="table-responsive">
                <table class="transactions-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Date</th>
                            <th>Method</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Details</th>
                        </tr>
                    </thead>
                    <tbody>
                    
                        <!-- 
                            NOTE: We assume your controller passes a list named 'transactionList'.
                            Each item in the list must contain:
                            - transactionId, userId, transactionDate, paymentMethod, transactionStatus
                            - A property, e.g., 'itemsJson', containing the transaction_details data as a JSON string.
                        -->
                        <c:forEach var="txn" items="${transactionList}">
                        <tr class="transaction-row" 
                            data-txn-id="${txn.transactionId}" 
                            data-user-id="${txn.userId}" 
                            data-date="${txn.transactionDate}" 
                            data-method="${txn.paymentMethod}" 
                            data-total="${txn.totalAmount}" 
                            data-status="${txn.transactionStatus}"
                            data-items='${txn.itemsJson}'> 
                            <td>${txn.transactionId}</td>
                            <td>${txn.userId}</td>
                            <td><fmt:formatDate pattern="MMM dd, yyyy" value="${txn.transactionDate}"/></td>
                            <td>${txn.paymentMethod}</td>
                            <td>
                                <fmt:formatNumber value="${txn.totalAmount}" type="currency" currencySymbol="₱"/>
                            </td>
                            <td>
                                <span class="status-badge status-${txn.transactionStatus}">${txn.transactionStatus}</span>
                            </td>
                            <td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                        </tr>
                        </c:forEach>
                        
                        <!-- MOCK DATA FOR TESTING (Remove once real data is available) -->
                        <c:if test="${empty transactionList}">
                            <tr class="transaction-row" data-txn-id="TXN1001" data-user-id="U458A" data-date="2025-10-08 14:30:00" data-method="Cash" data-total="3500.00" data-status="Delivered" data-items='[{"name": "The Romantic Bouquet", "product_id": 1, "unitPrice": 3500.00, "quantity": 1, "subtotal": 3500.00}, {"name": "Delivery Fee", "product_id": 99, "unitPrice": 0.00, "quantity": 1, "subtotal": 0.00}]'>
                                <td>TXN1001</td><td>U458A</td><td>Oct 08, 2025</td><td>Cash</td><td>₱3,500.00</td><td><span class="status-badge status-Delivered">Delivered</span></td><td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                            </tr>
                            <tr class="transaction-row" data-txn-id="TXN1002" data-user-id="U991B" data-date="2025-10-07 09:15:00" data-method="Online" data-total="4700.00" data-status="Shipped" data-items='[{"name": "Sunshine Sunflower Bouquet", "product_id": 2, "unitPrice": 1899.00, "quantity": 2, "subtotal": 3798.00}, {"name": "Gift Card", "product_id": 98, "unitPrice": 100.00, "quantity": 1, "subtotal": 100.00}]'>
                                <td>TXN1002</td><td>U991B</td><td>Oct 07, 2025</td><td>Online</td><td>₱4,700.00</td><td><span class="status-badge status-Shipped">Shipped</span></td><td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                            </tr>
                            <tr class="transaction-row" data-txn-id="TXN1003" data-user-id="U221D" data-date="2025-10-06 17:00:00" data-method="Card" data-total="5400.00" data-status="Pending" data-items='[{"name": "Butterfly Bouquet", "product_id": 3, "unitPrice": 5400.00, "quantity": 1, "subtotal": 5400.00}]'>
                                <td>TXN1003</td><td>U221D</td><td>Oct 06, 2025</td><td>Card</td><td>₱5,400.00</td><td><span class="status-badge status-Pending">Pending</span></td><td><button class="view-details-btn"><i class="fas fa-search"></i> View Details</button></td>
                            </tr>
                        </c:if>
                        
                    </tbody>
                </table>
            </div>

        </div> 
        
    </div> 
    
    
    <!-- --- TRANSACTION DETAILS MODAL --- -->
    <div id="transactionDetailsModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2 id="modal-txn-title">Transaction Details: TXNXXXX</h2>
                <button class="close-btn" data-modal-close>&times;</button>
            </div>
            
            <!-- Transaction Summary -->
            <div class="detail-group">
                <div class="detail-item"><strong>Customer ID:</strong> <span id="modal-user-id"></span></div>
                <div class="detail-item"><strong>Date:</strong> <span id="modal-date"></span></div>
                <div class="detail-item"><strong>Payment Method:</strong> <span id="modal-method"></span></div>
            </div>
            
            <h3 class="details-sub-header">Itemized Products (<i class="fas fa-receipt"></i> transaction_details)</h3>
            
            <!-- Itemized Products from 'transaction_details' table -->
            <div class="table-responsive">
                <table class="items-table">
                    <thead>
                        <tr>
                            <th>Product/Service</th>
                            <th>ID</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>
                    <tbody id="modal-items-tbody">
                        <!-- Items populated by JavaScript -->
                    </tbody>
                </table>
            </div>
            
            <div class="detail-group" style="border-top: 2px solid var(--primary-dark); margin-top: 20px; padding-top: 15px;">
                <div class="detail-item" style="font-size: 22px;"><strong>GRAND TOTAL:</strong> <span id="modal-total" style="color: var(--danger); font-size: 24px;"></span></div>
                <div class="detail-item"><strong>Status:</strong> <span id="modal-status"></span></div>
            </div>
            
        </div>
    </div>
    
    
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const modal = document.getElementById('transactionDetailsModal');
            const closeButtons = document.querySelectorAll('[data-modal-close]');
            const detailButtons = document.querySelectorAll('.view-details-btn');
            
            // Modal elements
            const modalTitle = document.getElementById('modal-txn-title');
            const modalUserId = document.getElementById('modal-user-id');
            const modalDate = document.getElementById('modal-date');
            const modalMethod = document.getElementById('modal-method');
            const modalTotal = document.getElementById('modal-total');
            const modalStatus = document.getElementById('modal-status');
            const modalItemsTbody = document.getElementById('modal-items-tbody');

            // Function to handle the actual currency formatting
            function formatCurrency(amount) {
                 // IMPORTANT: Use \${ to escape $ to prevent JSP parser from failing
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
                    // Find the nearest table row (transaction-row)
                    const row = event.target.closest('.transaction-row');
                    if (!row) return;

                    // 1. Retrieve data
                    const txnId = row.getAttribute('data-txn-id');
                    const userId = row.getAttribute('data-user-id');
                    const date = row.getAttribute('data-date');
                    const method = row.getAttribute('data-method');
                    const total = row.getAttribute('data-total');
                    const status = row.getAttribute('data-status');
                    const itemsJson = row.getAttribute('data-items');
                    
                    // Parse the itemized details. Use [] as fallback in case data-items is null/invalid
                    let items = [];
                    try {
                        items = JSON.parse(itemsJson || '[]'); 
                    } catch (e) {
                        console.error("Error parsing items JSON:", e);
                        // Optional: Show an error message in the modal
                    }

                    // 2. Populate Header and Summary
                    modalTitle.textContent = `Transaction Details: ${txnId}`;
                    modalUserId.textContent = userId;
                    // Try to parse the date as a Date object if possible, otherwise display raw string
                    const dateObj = new Date(date);
                    modalDate.textContent = isNaN(dateObj) ? date : dateObj.toLocaleDateString('en-US', {
                        year: 'numeric', month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit'
                    }); 
                    modalMethod.textContent = method;
                    modalTotal.textContent = formatCurrency(total);
                    
                    // 3. Populate Status
                    modalStatus.className = `status-badge status-${status}`;
                    modalStatus.textContent = status;
                    
                    // 4. Populate Items Table
                    modalItemsTbody.innerHTML = ''; // Clear previous items
                    if (items.length === 0) {
                        const tr = document.createElement('tr');
                        tr.innerHTML = `<td colspan="5" style="text-align: center; color: #888;">No item details available.</td>`;
                        modalItemsTbody.appendChild(tr);
                    } else {
                        items.forEach(item => {
                            const tr = document.createElement('tr');
                            // FIX: Use \${ to escape $ in template literals
                            tr.innerHTML = `
                                <td>\${item.name || 'N/A'}</td>
                                <td>\${item.product_id || 'N/A'}</td>
                                <td>\${formatCurrency(item.unitPrice)}</td>
                                <td>\${item.quantity}</td>
                                <td>\${formatCurrency(item.subtotal)}</td>
                            `;
                            modalItemsTbody.appendChild(tr);
                        });
                    }
                    
                    // 5. Open Modal
                    openModal();
                });
            });
            
        });
    </script>
</body>
</html>
