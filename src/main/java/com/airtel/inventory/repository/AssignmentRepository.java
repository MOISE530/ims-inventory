package com.airtel.inventory.repository;

import com.airtel.inventory.model.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
    
    List<Assignment> findByDeviceId(Long deviceId);
    
    List<Assignment> findByEmployeeId(Long employeeId);
    
    Optional<Assignment> findByDeviceIdAndReturnDateIsNull(Long deviceId);
    
    List<Assignment> findByReturnDateIsNull();
}
