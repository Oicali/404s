package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;
import java.util.Map;
import java.util.ArrayList; 
import java.util.HashMap; 

@Controller
public class UserController {

	private final UserService service; 

	// ⭐ FIX: Explicit Constructor for Dependency Injection (Preferred Method) ⭐
	@Autowired
	public UserController(UserService service) {
		this.service = service;
	}
	
	@ModelAttribute
	public void addLoggedUserToModel(HttpSession session, Model model) {
	     User loggedUser = (User) session.getAttribute("loggedUser");
	     model.addAttribute("loggedUser", loggedUser);

	}
	
	@GetMapping("/login")
	public String showLoginForm(Model model,
				@ModelAttribute("message") String message,
					@ModelAttribute("error") String error) {
	model.addAttribute("user", new User());
	model.addAttribute("message", message);
	model.addAttribute("error", error);
	return "login";

	}
	
	
	
	// Process login
	@PostMapping("/login")
	public String processLogin(@ModelAttribute("user") User user,
	RedirectAttributes redirectAttributes,
	HttpSession session) {
	User existingUser = service.findByEmailAndPassword(user.getEmail(), user.getPassword());

	if (existingUser != null) {
	//Save user in session
	session.setAttribute("loggedUser", existingUser);

	redirectAttributes.addFlashAttribute("message",
	"Login successful! Welcome " + existingUser.getFirstname());

	//Role-based redirection
	if (existingUser.getRole() == 1) {
	     return "redirect:/shop"; // ⭐ UPDATED: normal user redirects to the shop ⭐
	} else if (existingUser.getRole() == 0) {
	    // ADMIN ROLE (0) now redirects to the new dashboard JSP
	    return "redirect:/dashboard"; 
	}
}

	redirectAttributes.addFlashAttribute("error", "Invalid email or password!");
	return "redirect:/login"; // reload login page with error
	}
	
	//INDEX
	@GetMapping("/")
	public String userHome(Model model,
	HttpSession session,
	@ModelAttribute("message") String message) {
	User loggedUser = (User) session.getAttribute("loggedUser");

	model.addAttribute("loggedUser", loggedUser);
	model.addAttribute("users", service.getAllUsers());
	model.addAttribute("message", message);

	return "index";

	}
    
    // 🛍️ SHOP HANDLER: NEW METHOD FOR shop.jsp 🛍️
	/**
	 * USER SHOP HANDLER
	 * Maps the request to /shop and ensures the user is logged in.
	 */
    @GetMapping("/shop")
    public String showShop(HttpSession session,
            Model model, 
            RedirectAttributes redirectAttributes) {

        User loggedUser = (User) session.getAttribute("loggedUser");

		// Security check: User must be logged in to view the shop
		if (loggedUser == null) {
			redirectAttributes.addFlashAttribute("error",  "Please log in to view the shop.");
			return "redirect:/login";
			}
			
		// In a real application, you would fetch the product list here
		// model.addAttribute("products", productService.getAllProducts());
        
        // Returns the view name 'shop', which Spring resolves to shop.jsp
        return "shop"; 
    }
	
	/**
	 * ADMIN DASHBOARD HANDLER
	 * This replaces the previous /admin-home endpoint.
	 */
	@GetMapping("/dashboard")
	public String adminDashboard(HttpSession session,
			Model model,
			RedirectAttributes redirectAttributes,
			@ModelAttribute("message") String message) {
        
        // 🛠️ FIX: Corrected casting from DUser to User
		User loggedUser = (User) session.getAttribute("loggedUser"); 

		// Security check: If not logged in or role is not Admin (0), redirect to login
		if (loggedUser == null || loggedUser.getRole() != 0) {
			redirectAttributes.addFlashAttribute("error",  "Unauthorized access! Please log in as Admin.");
			return "redirect:/login";
			}
			
			// Pass necessary data to the dashboard view (dashboard.jsp)
			model.addAttribute("users", service.getAllUsers());
			model.addAttribute("message", message);
			
			// Return the view name corresponding to dashboard.jsp (e.g., 'dashboard')
			return "dashboard"; 
	}
    
    // 🚀 PRODUCTS HANDLER
	/**
	 * ADMIN PRODUCTS HANDLER
	 * Maps the request from the dashboard link to the products.jsp view.
	 */
	@GetMapping("/products")
	public String viewProducts(HttpSession session,
			Model model,
			RedirectAttributes redirectAttributes) {
		
		User loggedUser = (User) session.getAttribute("loggedUser");

		// Security check: Only Admins (role 0) should access products
		if (loggedUser == null || loggedUser.getRole() != 0) {
			redirectAttributes.addFlashAttribute("error",  "Unauthorized access! Please log in as Admin.");
			return "redirect:/login";
			}
			
		// Returns the view name 'products', which Spring resolves to products.jsp
		return "products"; 
	}

    // ⭐ ORDERS HANDLER: NEW METHOD FOR orders.jsp ⭐
	/**
	 * ADMIN ORDERS HANDLER
	 * Fetches transaction data and maps the request to the orders.jsp view.
	 */
    @GetMapping("/orders") // This is the URL the user should go to: http://localhost:8080/orders
    public String showOrders(HttpSession session,
            Model model, 
            RedirectAttributes redirectAttributes) {

        User loggedUser = (User) session.getAttribute("loggedUser");

		// Security check: Only Admins (role 0) should access orders
		if (loggedUser == null || loggedUser.getRole() != 0) {
			redirectAttributes.addFlashAttribute("error",  "Unauthorized access! Please log in as Admin.");
			return "redirect:/login";
			}
			
        // --- 1. Fetch REAL Data (TBD) ---
        // When you implement your service layer, you'll replace the line below.

        // --- 2. Add Dummy Data for Testing (Used until Service is ready) ---
        List<Map<String, Object>> mockTransactionList = createMockTransactions();
        
        // --- 3. Pass Data to JSP ---
        // The orders.jsp uses JSTL to loop over this list.
        model.addAttribute("transactionList", mockTransactionList);
        
        // Returns the view name 'orders', which Spring resolves to orders.jsp
        return "orders"; 
    }
    
    // 💵 TRANSACTIONS HANDLER: NEW METHOD FOR transactions.jsp 💵
    /**
	 * ADMIN TRANSACTIONS HANDLER
	 * Maps the request to /transactions and passes the list of transactions to the JSP.
	 */
    @GetMapping("/transactions") // This is the new URL mapping
    public String showTransactions(HttpSession session,
            Model model, 
            RedirectAttributes redirectAttributes) {

        User loggedUser = (User) session.getAttribute("loggedUser");

		// Security check: Only Admins (role 0) should access transactions
		if (loggedUser == null || loggedUser.getRole() != 0) {
			redirectAttributes.addFlashAttribute("error",  "Unauthorized access! Please log in as Admin.");
			return "redirect:/login";
			}
			
        // --- Using the same mock data for now, as it fits the JSP structure ---
        List<Map<String, Object>> mockTransactionList = createMockTransactions();
        
        // --- Pass Data to JSP ---
        // The transactions.jsp uses JSTL to loop over this list.
        // It uses the attribute name "transactionList"
        model.addAttribute("transactionList", mockTransactionList);
        
        // Returns the view name 'transactions', which Spring resolves to transactions.jsp
        return "transactions"; 
    }


    /**
     * Helper function to create mock data for demonstration
     * NOTE: In a real app, this data would come from the TransactionService.
     */
    private List<Map<String, Object>> createMockTransactions() {
        // This simulates the aggregated data your service layer would provide
        List<Map<String, Object>> list = new ArrayList<>();
        
        // NOTE on Statuses: The transactions.jsp uses "Delivered", "Shipped", "Pending"
        // The mock data used in /orders has "Paid", "Pending", "Shipped", "Failed". 
        // I will adjust this mock data slightly to match the expected statuses from your DB schema image 
        // ("Pending", "Shipped", "Delivered") for better JSP compatibility.
        
        list.add(Map.of("txnId", "TXN1001", "userId", "U458A", "date", "Oct 08, 2025", "method", "GCash", "total", 3500.00, "status", "Delivered",
                   "itemsJson", "[{\"name\": \"The Romantic Bouquet\", \"unitPrice\": 3500.00, \"quantity\": 1, \"subtotal\": 3500.00, \"product_name\": \"The Romantic Bouquet\"}]"));
                   
        list.add(Map.of("txnId", "TXN1002", "userId", "U991B", "date", "Oct 07, 2025", "method", "COD", "total", 4700.00, "status", "Shipped",
                   "itemsJson", "[{\"name\": \"Sunshine Bouquet\", \"unitPrice\": 1899.00, \"quantity\": 2, \"subtotal\": 3798.00, \"product_name\": \"Sunshine Bouquet\"}, {\"name\": \"Gift Card\", \"unitPrice\": 902.00, \"quantity\": 1, \"subtotal\": 902.00, \"product_name\": \"Gift Card\"}]"));
                   
        list.add(Map.of("txnId", "TXN1003", "userId", "U221D", "date", "Oct 06, 2025", "method", "Card", "total", 5400.00, "status", "Pending",
                   "itemsJson", "[{\"name\": \"Butterfly Bouquet\", \"unitPrice\": 5400.00, \"quantity\": 1, \"subtotal\": 5400.00, \"product_name\": \"Butterfly Bouquet\"}]"));

        list.add(Map.of("txnId", "TXN1004", "userId", "U600E", "date", "Oct 05, 2025", "method", "PayPal", "total", 1100.00, "status", "Delivered",
                   "itemsJson", "[{\"name\": \"Money Bouquet\", \"unitPrice\": 1100.00, \"quantity\": 1, \"subtotal\": 1100.00, \"product_name\": \"Money Bouquet\"}]"));
                   
        return list;
    }
	
	/**
	 * Handler for the GET /register page.
	 */
	@GetMapping("/register")
	public String addUserForm(Model model, 
	                          @ModelAttribute("message") String message,
	                          @ModelAttribute("oldUser") User oldUser, 
	                          @ModelAttribute("error") String error) {  
	
	    // If oldUser is passed (meaning a redirect from /save with error occurred), use it.
	    if (oldUser != null && oldUser.getEmail() != null) {
	        model.addAttribute("user", oldUser);
	    } else {
	        // Otherwise, show a clean form
	        model.addAttribute("user", new User());
	    }
	    
	    model.addAttribute("message", message);
	    model.addAttribute("error", error); 

	    return "register";
	}
	
	/**
	 * Handler for the POST /save submission.
	 */
	@PostMapping("/save")
	public String saveUser(@ModelAttribute("user") User user,
							RedirectAttributes redirectAttributes) {
	String result = service.saveUser(user);
	
	if (result.equals("email_exists")) {
		// 1. Set the error message for the JSP to read
		redirectAttributes.addFlashAttribute("error", "Email is already in use!");
		
		// 2. Pass the entire submitted 'user' object back to the GET /register method.
		redirectAttributes.addFlashAttribute("oldUser", user);
		
		return "redirect:/register"; 
	} else {
		redirectAttributes.addFlashAttribute("message", "Successfully registered! Please log in.");
		return "redirect:/login";
	}
	
	}
	
	/**
	 * LOGOUT HANDLER
	 * Terminates the user session and redirects to login.
	 */
	@GetMapping("/logout")
	public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
		// Invalidate and clear the session
		session.invalidate();
		redirectAttributes.addFlashAttribute("message", "Logged out successfully!");
		return "redirect:/login";
	}
	
}
