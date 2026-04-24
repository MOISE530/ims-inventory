-- PostgreSQL Database Setup for Render Deployment
-- Airtel Inventory Management System

-- Create database (Render handles this automatically)
-- CREATE DATABASE airtel_inventory;

-- Create Users Table
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Devices Table
CREATE TABLE IF NOT EXISTS devices (
    id BIGSERIAL PRIMARY KEY,
    asset_tag VARCHAR(50) UNIQUE NOT NULL,
    serial_number VARCHAR(100) UNIQUE NOT NULL,
    device_type VARCHAR(50) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    specifications TEXT,
    device_condition VARCHAR(20) DEFAULT 'Good',
    status VARCHAR(20) DEFAULT 'Available',
    purchase_date DATE,
    warranty_until DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Employees Table
CREATE TABLE IF NOT EXISTS employees (
    id BIGSERIAL PRIMARY KEY,
    employee_id VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    designation VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Assignments Table
CREATE TABLE IF NOT EXISTS assignments (
    id BIGSERIAL PRIMARY KEY,
    device_id BIGINT NOT NULL,
    employee_id BIGINT NOT NULL,
    assigned_date DATE DEFAULT CURRENT_DATE,
    return_date DATE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (device_id) REFERENCES devices(id),
    FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- Create Indexes for Performance
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_devices_asset_tag ON devices(asset_tag);
CREATE INDEX IF NOT EXISTS idx_devices_serial_number ON devices(serial_number);
CREATE INDEX IF NOT EXISTS idx_devices_status ON devices(status);
CREATE INDEX IF NOT EXISTS idx_devices_device_type ON devices(device_type);
CREATE INDEX IF NOT EXISTS idx_devices_brand ON devices(brand);
CREATE INDEX IF NOT EXISTS idx_employees_employee_id ON employees(employee_id);
CREATE INDEX IF NOT EXISTS idx_employees_department ON employees(department);
CREATE INDEX IF NOT EXISTS idx_assignments_device_id ON assignments(device_id);
CREATE INDEX IF NOT EXISTS idx_assignments_employee_id ON assignments(employee_id);
CREATE INDEX IF NOT EXISTS idx_assignments_return_date ON assignments(return_date);

-- Insert Admin User (only if not exists)
INSERT INTO users (username, password, full_name, role) 
VALUES ('24RP01839', '24RP03971', 'System Administrator', 'admin')
ON CONFLICT (username) DO NOTHING;

-- Insert Sample Data (only if tables are empty)
INSERT INTO employees (employee_id, full_name, department, designation, email, phone) VALUES
('EMP001', 'John Smith', 'IT', 'Software Engineer', 'john.smith@airtel.com', '+1234567890'),
('EMP002', 'Sarah Johnson', 'HR', 'HR Manager', 'sarah.johnson@airtel.com', '+1234567891'),
('EMP003', 'Michael Brown', 'Finance', 'Accountant', 'michael.brown@airtel.com', '+1234567892'),
('EMP004', 'Emily Davis', 'Marketing', 'Marketing Manager', 'emily.davis@airtel.com', '+1234567893'),
('EMP005', 'David Wilson', 'Operations', 'Operations Manager', 'david.wilson@airtel.com', '+1234567894')
ON CONFLICT (employee_id) DO NOTHING;

INSERT INTO devices (asset_tag, serial_number, device_type, brand, model, specifications, device_condition, status, purchase_date, warranty_until) VALUES
('LAP001', 'SN123456789', 'Laptop', 'Dell', 'Latitude 5420', 'Intel i7, 16GB RAM, 512GB SSD', 'Excellent', 'Available', '2023-01-15', '2025-01-15'),
('LAP002', 'SN123456790', 'Laptop', 'HP', 'EliteBook 840', 'Intel i5, 8GB RAM, 256GB SSD', 'Good', 'Assigned', '2023-02-20', '2025-02-20'),
('LAP003', 'SN123456791', 'Laptop', 'Lenovo', 'ThinkPad T14', 'Intel i7, 16GB RAM, 1TB SSD', 'Good', 'Available', '2023-03-10', '2025-03-10'),
('MOB001', 'SN987654321', 'Mobile', 'Samsung', 'Galaxy S23', '256GB, 8GB RAM, 5G', 'Excellent', 'Assigned', '2023-04-05', '2025-04-05'),
('MOB002', 'SN987654322', 'Mobile', 'Apple', 'iPhone 14', '128GB, 6GB RAM, 5G', 'Good', 'Available', '2023-04-10', '2025-04-10'),
('TAB001', 'SN555555555', 'Tablet', 'iPad', 'iPad Pro 11', '256GB, M2 chip', 'Excellent', 'Available', '2023-05-01', '2025-05-01'),
('MON001', 'SN111111111', 'Monitor', 'Dell', 'U2720Q', '27 inch 4K USB-C', 'Good', 'Assigned', '2023-01-20', '2025-01-20'),
('MON002', 'SN111111112', 'Monitor', 'LG', '27UL850', '27 inch 4K HDR', 'Excellent', 'Available', '2023-02-15', '2025-02-15'),
('KEY001', 'SN222222222', 'Keyboard', 'Logitech', 'MX Keys', 'Wireless, Backlit', 'Good', 'Available', '2023-03-01', '2025-03-01'),
('MOU001', 'SN333333333', 'Mouse', 'Logitech', 'MX Master 3', 'Wireless, Ergonomic', 'Excellent', 'Assigned', '2023-03-15', '2025-03-15')
ON CONFLICT (asset_tag) DO NOTHING;

-- Create Views for Reporting
CREATE OR REPLACE VIEW device_summary AS
SELECT 
    d.device_type,
    d.brand,
    COUNT(*) as total_devices,
    COUNT(CASE WHEN d.status = 'Available' THEN 1 END) as available_devices,
    COUNT(CASE WHEN d.status = 'Assigned' THEN 1 END) as assigned_devices,
    COUNT(CASE WHEN d.device_condition = 'Excellent' THEN 1 END) as excellent_condition,
    COUNT(CASE WHEN d.device_condition = 'Good' THEN 1 END) as good_condition
FROM devices d
GROUP BY d.device_type, d.brand;

-- Create Functions for Business Logic
CREATE OR REPLACE FUNCTION get_device_status_count(status_param VARCHAR(20))
RETURNS INTEGER AS $$
BEGIN
    RETURN (
        SELECT COUNT(*) 
        FROM devices 
        WHERE status = status_param
    );
END;
$$ LANGUAGE plpgsql;

-- Create Trigger for Updated Timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply triggers to tables
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_devices_updated_at BEFORE UPDATE ON devices
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_employees_updated_at BEFORE UPDATE ON employees
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_assignments_updated_at BEFORE UPDATE ON assignments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Display Setup Completion
SELECT 'Airtel Inventory Database Setup Complete!' as status;
SELECT 'Admin Credentials: admin / admin123' as credentials;
SELECT 'Ready for Render Deployment' as deployment_status;
