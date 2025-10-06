package com.example.demo.controller;

import com.example.demo.model.User;
import com.example.demo.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class UserController {

	@Autowired
	private UserService service;
	
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
	     return "redirect:/"; // normal user
	} else if (existingUser.getRole() == 0) {
	    // ADMIN ROLE (0) now redirects to the new dashboard JSP test
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
    
    // 🚀 PRODUCTS HANDLER: This is what makes the link work 🚀
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