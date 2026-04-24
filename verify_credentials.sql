-- Verify Admin Credentials Script
-- Run this script to check if admin credentials exist in the database

USE airtel_inventory;

-- Check if admin user exists
SELECT 'Checking admin user...' as status;
SELECT username, password, full_name, role FROM users WHERE username = '24RP01839';

-- If no admin user exists, insert one
INSERT IGNORE INTO users (username, password, full_name, role) 
VALUES ('24RP01839', '24RP03971', 'System Administrator', 'admin');

-- Verify the admin user was created/exists
SELECT 'Admin credentials verified:' as result;
SELECT username as 'Username', password as 'Password', full_name as 'Full Name', role as 'Role' 
FROM users WHERE username = '24RP01839';

-- Display login information
SELECT 'Login Credentials:' as login_info;
SELECT 'Username: 24RP01839' as username;
SELECT 'Password: 24RP03971' as password;
SELECT 'URL: http://localhost:8081/airtel-inventory/login' as access_url;
