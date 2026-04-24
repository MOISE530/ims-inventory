package com.airtel.inventory.service;

import com.airtel.inventory.model.Device;
import com.airtel.inventory.repository.DeviceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DeviceService {
    
    @Autowired
    private DeviceRepository deviceRepository;
    
    public Device save(Device device) {
        if (device.getStatus() == null) {
            device.setStatus("Available");
        }
        if (device.getDeviceCondition() == null) {
            device.setDeviceCondition("Good");
        }
        return deviceRepository.save(device);
    }
    
    public List<Device> findAll() {
        return deviceRepository.findAll();
    }
    
    public Optional<Device> findById(Long id) {
        return deviceRepository.findById(id);
    }
    
    public void deleteById(Long id) {
        deviceRepository.deleteById(id);
    }
    
    public long count() {
        return deviceRepository.count();
    }
    
    public long countAvailable() {
        return deviceRepository.findByStatus("Available").size();
    }
    
    public List<Device> findByStatus(String status) {
        return deviceRepository.findByStatus(status);
    }
    
    public Optional<Device> findByAssetTag(String assetTag) {
        return deviceRepository.findByAssetTag(assetTag);
    }
    
    public Optional<Device> findBySerialNumber(String serialNumber) {
        return deviceRepository.findBySerialNumber(serialNumber);
    }
    
    public List<Device> findByDeviceType(String deviceType) {
        return deviceRepository.findByDeviceType(deviceType);
    }
    
    public List<Device> findByBrand(String brand) {
        return deviceRepository.findByBrand(brand);
    }
}
