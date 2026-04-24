package com.airtel.inventory.controller;

import com.airtel.inventory.model.User;
import com.airtel.inventory.repository.UserRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginController {
    
    @Autowired
    private UserRepository userRepository;
    
    @GetMapping("/login")
    public String showLoginForm(@RequestParam(value = "error", required = false) String error, 
                              org.springframework.ui.Model model) {
        if (error != null) {
            model.addAttribute("error", "Invalid username or password");
        }
        return "login";
    }
    
    @PostMapping("/login")
    public String processLogin(@RequestParam("username") String username,
                             @RequestParam("password") String password,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        User user = userRepository.findByUsernameAndPassword(username, password).orElse(null);
        
        if (user != null) {
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("role", user.getRole());
            return "redirect:/dashboard";
        } else {
            return "redirect:/login?error";
        }
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
