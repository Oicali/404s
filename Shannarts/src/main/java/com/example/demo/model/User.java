package com.example.demo.model;
import jakarta.persistence .*;
import jakarta.validation.constraints .*;

@Entity
@Table(name = "user")

public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotBlank(message = "First name is required")
	private String firstname;

	@NotBlank(message = "Last name is required")
	private String lastname;

	@Email(message = "Invalid email format")
	@NotBlank(message = "Email is required")
	@Column(unique = true, nullable = false)
	private String email;

	private String phone;

	@NotBlank(message = "Password is required")
	private String password;

	private int role = 1; // default customer
	

public User() {

}

public User(String firstname, String lastname, String email, String phone, String password, int role) {
       this.firstname = firstname;
       this.lastname = lastname;
       this.email = email;
       this.phone = phone;
       this.password = password;
       this.role = role;
  
}

public Long getId() {
	return id;
}

public void setId(Long id) {
	this.id = id;
}

public String getFirstname() {
	return firstname;
}

public void setFirstname(String firstname) {
	this.firstname = firstname;
}

public String getLastname() {
	return lastname;
}

public void setLastname(String lastname) {
	this.lastname = lastname;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getPhone() {
	return phone;
}

public void setPhone(String phone) {
	this.phone = phone;
}

public String getPassword() {
	return password;
}

public void setPassword(String password) {
	this.password = password;
}

public int getRole() {
	return role;
}

public void setRole(int role) {
	this.role = role;
}




@Override



public String toString() {
    return "User{" +
     "id=" + id +
     ", firstname='" + firstname + '\'' +
      ", lastname='" + lastname + '\'' +
      ", email='" + email + '\'' +
      ", phone-'" + phone + '\'' +
      ", role=" + role +

      '}';

}
}
 

