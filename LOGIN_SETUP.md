# Login Credentials Setup Guide

## Default Admin Credentials

The Airtel Inventory Management System comes with pre-configured admin credentials:

- **Username**: `24RP01839`
- **Password**: `24RP03971`

## How to Set Up the Credentials

### Option 1: Using the Database Setup Script (Recommended)
1. Open phpMyAdmin (http://localhost/phpmyadmin)
2. Select the `airtel_inventory` database
3. Click "Import" and select the `database_setup.sql` file
4. The admin user will be created automatically

### Option 2: Using the Verification Script
1. Open phpMyAdmin
2. Select the `airtel_inventory` database
3. Click "SQL" tab
4. Copy and paste the contents of `verify_credentials.sql`
5. Click "Go" to execute

### Option 3: Manual SQL Execution
```sql
USE airtel_inventory;

INSERT INTO users (username, password, full_name, role) 
VALUES ('admin', 'admin123', 'System Administrator', 'admin');
```

## Verify Credentials are Working

1. Start the application
2. Navigate to: http://localhost:8081/airtel-inventory/login
3. Enter username: `admin`
4. Enter password: `admin123`
5. Click "Sign In"

## Login Interface Features

The login page includes:
- ✅ Default credentials displayed prominently
- ✅ Professional Airtel-branded design
- ✅ Responsive layout for all devices
- ✅ Clear error messages for invalid credentials
- ✅ Modern glassmorphism design

## Troubleshooting

### If Login Fails:
1. **Check Database**: Ensure the `airtel_inventory` database exists
2. **Verify User**: Run the verification script to check if admin user exists
3. **Check Application**: Ensure the application is running on port 8081
4. **Clear Cache**: Restart the application if needed

### Reset Admin Password:
```sql
UPDATE users SET password = 'admin123' WHERE username = 'admin';
```

### Create Additional Admin Users:
```sql
INSERT INTO users (username, password, full_name, role) 
VALUES ('your_username', 'your_password', 'Your Name', 'admin');
```

## Security Notes

- The default credentials are intended for initial setup
- Change the admin password in production environments
- The password is stored in plain text for demo purposes
- Consider implementing password hashing for production use

## Access Information

- **Application URL**: http://localhost:8081/airtel-inventory/login
- **Database**: MySQL on localhost:3306/airtel_inventory
- **Context Path**: /airtel-inventory
- **Port**: 8081

---

**Ready to use!** The credentials are pre-configured and displayed on the login page for easy access.
