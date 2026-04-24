package com.airtel.inventory.controller;

import com.airtel.inventory.service.DeviceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.ui.Model;

@Controller
public class DashboardController {
    
    @Autowired
    private DeviceService deviceService;
    
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        
        String fullName = (String) session.getAttribute("fullName");
        model.addAttribute("fullName", fullName);
        
        long totalDevices = deviceService.count();
        model.addAttribute("totalDevices", totalDevices);
        
        long availableDevices = deviceService.countAvailable();
        model.addAttribute("availableDevices", availableDevices);
        
        return "dashboard";
    }
    
    @GetMapping("/")
    public String home() {
        return "redirect:/dashboard";
    }
}
