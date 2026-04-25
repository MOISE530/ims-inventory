-- Airtel Inventory Management System Database Setup
-- MySQL 8.0 Compatible Script

-- Create Database
CREATE DATABASE IF NOT EXISTS airtel_inventory 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

-- Use the database
USE airtel_inventory;

-- Drop existing tables if they exist (for fresh setup)
DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS devices;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS users;

-- Create Users Table
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100),
    role VARCHAR(20) DEFAULT 'staff',
    INDEX idx_username (username)
);

-- Create Devices Table
CREATE TABLE devices (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    asset_tag VARCHAR(50) UNIQUE NOT NULL,
    serial_number VARCHAR(100) UNIQUE,
    device_type VARCHAR(20) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    specifications TEXT,
    device_condition VARCHAR(20) DEFAULT 'Good',
    status VARCHAR(20) DEFAULT 'Available',
    purchase_date DATE,
    warranty_until DATE,
    INDEX idx_asset_tag (asset_tag),
    INDEX idx_serial_number (serial_number),
    INDEX idx_status (status),
    INDEX idx_device_type (device_type),
    INDEX idx_brand (brand)
);

-- Create Employees Table
CREATE TABLE employees (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    employee_id VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    designation VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    INDEX idx_employee_id (employee_id),
    INDEX idx_department (department)
);

-- Create Assignments Table
CREATE TABLE assignments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    device_id BIGINT,
    employee_id BIGINT,
    assigned_date DATE,
    return_date DATE,
    notes TEXT,
    INDEX idx_device_id (device_id),
    INDEX idx_employee_id (employee_id),
    INDEX idx_assigned_date (assigned_date),
    INDEX idx_return_date (return_date)
);

-- Insert Admin User
INSERT INTO users (username, password, full_name, role) 
VALUES ('24RP01839', '24RP03971', 'System Administrator', 'admin');

-- Insert Sample Employee
INSERT INTO employees (employee_id, full_name, department, designation, email, phone) 
VALUES ('EMP001', 'John Doe', 'IT', 'Manager', 'john.doe@airtel.com', '+1234567890');

-- Insert Sample Devices for Testing
INSERT INTO devices (asset_tag, serial_number, device_type, brand, model, specifications, device_condition, status, purchase_date, warranty_until) VALUES
('LAP-001', 'SN123456789', 'Laptop', 'Dell', 'XPS 15', 'Intel i7, 16GB RAM, 512GB SSD', 'Good', 'Available', '2023-01-15', '2026-01-15'),
('LAP-002', 'SN987654321', 'Laptop', 'HP', 'EliteBook', 'Intel i5, 8GB RAM, 256GB SSD', 'Good', 'Available', '2023-03-20', '2026-03-20'),
('MOB-001', 'SN456789123', 'Mobile', 'Apple', 'iPhone 14', '128GB, Blue', 'New', 'Available', '2023-06-10', '2025-06-10'),
('DT-001', 'SN789123456', 'Desktop', 'Lenovo', 'ThinkCentre', 'Intel i7, 16GB RAM, 1TB HDD', 'Good', 'Assigned', '2022-11-15', '2025-11-15'),
('LAP-003', 'SN321654987', 'Laptop', 'Apple', 'MacBook Pro', 'M2, 16GB RAM, 512GB SSD', 'Good', 'Available', '2023-07-01', '2026-07-01');

-- Insert Sample Assignment
INSERT INTO assignments (device_id, employee_id, assigned_date, return_date, notes) 
VALUES (4, 1, '2023-01-20', NULL, 'Assigned to IT Manager for daily use');

-- Add more sample employees
INSERT INTO employees (employee_id, full_name, department, designation, email, phone) VALUES
('EMP002', 'Jane Smith', 'HR', 'HR Manager', 'jane.smith@airtel.com', '+1234567891'),
('EMP003', 'Mike Johnson', 'Finance', 'Finance Manager', 'mike.johnson@airtel.com', '+1234567892'),
('EMP004', 'Sarah Williams', 'Marketing', 'Marketing Manager', 'sarah.williams@airtel.com', '+1234567893'),
('EMP005', 'Robert Brown', 'Operations', 'Operations Manager', 'robert.brown@airtel.com', '+1234567894');

-- Add more sample devices
INSERT INTO devices (asset_tag, serial_number, device_type, brand, model, specifications, device_condition, status, purchase_date, warranty_until) VALUES
('MOB-002', 'SN654987321', 'Mobile', 'Samsung', 'Galaxy S23', '256GB, Black', 'New', 'Available', '2023-08-15', '2025-08-15'),
('TAB-001', 'SN147258369', 'Mobile', 'Apple', 'iPad Pro', '11-inch, 128GB, WiFi', 'Good', 'Available', '2023-05-20', '2026-05-20'),
('DT-002', 'SN369258147', 'Desktop', 'Dell', 'OptiPlex', 'Intel i5, 8GB RAM, 256GB SSD', 'Good', 'Available', '2023-04-10', '2026-04-10'),
('LAP-004', 'SN258147963', 'Laptop', 'Lenovo', 'ThinkPad', 'Intel i7, 16GB RAM, 512GB SSD', 'Good', 'Under Repair', '2022-12-01', '2025-12-01'),
('MOB-003', 'SN963258741', 'Mobile', 'OnePlus', '11 Pro', '256GB, Green', 'Good', 'Available', '2023-09-01', '2025-09-01');

-- Create a view for device assignment summary
CREATE VIEW device_assignment_summary AS
SELECT 
    d.id,
    d.asset_tag,
    d.serial_number,
    d.device_type,
    d.brand,
    d.model,
    d.status,
    d.device_condition,
    e.employee_id,
    e.full_name as employee_name,
    e.department,
    a.assigned_date,
    a.return_date,
    a.notes
FROM devices d
LEFT JOIN assignments a ON d.id = a.device_id AND a.return_date IS NULL
LEFT JOIN employees e ON a.employee_id = e.id;

-- Create a stored procedure for device availability check
DELIMITER //
CREATE PROCEDURE CheckDeviceAvailability(IN device_id BIGINT)
BEGIN
    SELECT 
        d.asset_tag,
        d.brand,
        d.model,
        d.status,
        CASE 
            WHEN d.status = 'Available' THEN 'Device is available for assignment'
            WHEN d.status = 'Assigned' THEN 'Device is currently assigned'
            WHEN d.status = 'Under Repair' THEN 'Device is under repair'
            WHEN d.status = 'Lost' THEN 'Device is reported as lost'
            ELSE 'Unknown status'
        END as availability_status
    FROM devices d
    WHERE d.id = device_id;
END //
DELIMITER ;

-- Create a function to count devices by status
DELIMITER //
CREATE FUNCTION CountDevicesByStatus(status_param VARCHAR(20))
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE device_count INT;
    SELECT COUNT(*) INTO device_count FROM devices WHERE status = status_param;
    RETURN device_count;
END //
DELIMITER ;

-- Display setup completion message
SELECT 'IMS Database Setup Complete!' as message;
SELECT 'Database: airtel_inventory' as database_name;
SELECT 'Admin User: 24RP01839 / 24RP03971' as admin_credentials;
SELECT 'Sample Employee: EMP001 - John Doe' as sample_employee;
SELECT 'Access URL: http://localhost:8081/airtel-inventory/login' as access_url;
