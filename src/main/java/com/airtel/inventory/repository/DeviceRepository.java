package com.airtel.inventory.repository;

import com.airtel.inventory.model.Device;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DeviceRepository extends JpaRepository<Device, Long> {
    
    List<Device> findByStatus(String status);
    
    Optional<Device> findByAssetTag(String assetTag);
    
    Optional<Device> findBySerialNumber(String serialNumber);
    
    List<Device> findByDeviceType(String deviceType);
    
    List<Device> findByBrand(String brand);
}
