package com.airtel.inventory.controller;

import com.airtel.inventory.model.Device;
import com.airtel.inventory.service.DeviceService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/devices")
public class DeviceController {
    
    @Autowired
    private DeviceService deviceService;
    
    @GetMapping({"", "/"})
    public String listDevices(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("devices", deviceService.findAll());
        return "devices/list";
    }
    
    @GetMapping("/add")
    public String showAddDeviceForm(HttpSession session, Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("device", new Device());
        return "devices/form";
    }
    
    @PostMapping("/add")
    public String addDevice(@ModelAttribute Device device, 
                           RedirectAttributes redirectAttributes) {
        try {
            deviceService.save(device);
            redirectAttributes.addFlashAttribute("success", "Device added successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error adding device: " + e.getMessage());
        }
        return "redirect:/devices";
    }
    
    @GetMapping("/delete/{id}")
    public String deleteDevice(@PathVariable Long id, 
                              RedirectAttributes redirectAttributes) {
        try {
            deviceService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Device deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error deleting device: " + e.getMessage());
        }
        return "redirect:/devices";
    }
    
    @GetMapping("/search")
    public String searchDevices(@RequestParam("keyword") String keyword,
                              HttpSession session,
                              Model model) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return "redirect:/login";
        }
        
        var devices = deviceService.findAll().stream()
                .filter(device -> 
                    device.getAssetTag().toLowerCase().contains(keyword.toLowerCase()) ||
                    device.getSerialNumber().toLowerCase().contains(keyword.toLowerCase()) ||
                    device.getBrand().toLowerCase().contains(keyword.toLowerCase()) ||
                    device.getModel().toLowerCase().contains(keyword.toLowerCase()))
                .toList();
        
        model.addAttribute("devices", devices);
        model.addAttribute("searchKeyword", keyword);
        return "devices/list";
    }
}
