package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;

import java.util.List;


@Service
public class UserService {
	


	@Autowired
	private UserRepository repo;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	public String saveUser(User user) {
		if (repo.existsByEmail(user.getEmail())) {
		return "email_exists";
		}
		
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		repo.save(user);
		return "success";

		}
	public List<User> getAllUsers() {
		return repo.findAll();

	}
	
	public void deleteUser(Long id) {
		repo.deleteById(id);
	}
	
	public User getUserById(Long id) {
		return repo.findById(id).orElse(null);
	
		
	}
	public User findByEmailAndPassword(String email, String password) {
		User user = repo.findByEmail(email);
		if (user != null && passwordEncoder.matches(password, user.getPassword())) {
		  return user;
		}
	  	return null;
	}
}

