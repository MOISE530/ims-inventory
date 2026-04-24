package com.airtel.inventory.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDate;

@Entity
@Table(name = "assignments")
public class Assignment {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private Long deviceId;
    
    private Long employeeId;
    
    private LocalDate assignedDate;
    
    private LocalDate returnDate;
    
    private String notes;
    
    public Assignment() {}
    
    public Assignment(Long deviceId, Long employeeId, LocalDate assignedDate, 
                     LocalDate returnDate, String notes) {
        this.deviceId = deviceId;
        this.employeeId = employeeId;
        this.assignedDate = assignedDate;
        this.returnDate = returnDate;
        this.notes = notes;
    }
    
    public Long getId() {
        return id;
    }
    
    public void setId(Long id) {
        this.id = id;
    }
    
    public Long getDeviceId() {
        return deviceId;
    }
    
    public void setDeviceId(Long deviceId) {
        this.deviceId = deviceId;
    }
    
    public Long getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(Long employeeId) {
        this.employeeId = employeeId;
    }
    
    public LocalDate getAssignedDate() {
        return assignedDate;
    }
    
    public void setAssignedDate(LocalDate assignedDate) {
        this.assignedDate = assignedDate;
    }
    
    public LocalDate getReturnDate() {
        return returnDate;
    }
    
    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }
    
    public String getNotes() {
        return notes;
    }
    
    public void setNotes(String notes) {
        this.notes = notes;
    }
}
