# IMS - Inventory Management System

A complete, production-ready inventory management system to track end-user equipment including laptops, desktops, and mobile phones. Built with Spring Boot MVC architecture and MySQL database.

## 🚀 Features

- **User Authentication**: Secure login system with session management
- **Dashboard**: Real-time statistics and overview of inventory
- **Device Management**: Complete CRUD operations for device tracking
- **Search Functionality**: Advanced search by asset tag, serial number, brand, or model
- **Responsive Design**: Modern, mobile-friendly interface
- **MySQL Integration**: Robust database connectivity with sample data

## 🛠 Technology Stack

- **Spring Boot 3.2.0** - MVC Framework
- **Java 17** - Programming Language
- **MySQL 8.0** - Database (via XAMPP)
- **Spring Data JPA** - Data Access Layer
- **Thymeleaf** - Template Engine
- **Maven** - Build Automation
- **Apache Tomcat** - Embedded Server

## 📋 Prerequisites

1. **Java 17** or higher installed
2. **Apache Maven** installed
3. **XAMPP** with MySQL 8.0 installed and running
4. **Eclipse IDE** (recommended) or any compatible IDE

## 🗄 Database Setup

### Step 1: Start MySQL Server
- Open XAMPP Control Panel
- Start the Apache and MySQL services
- Ensure MySQL is running on port 3306

### Step 2: Create Database
1. Open phpMyAdmin (http://localhost/phpmyadmin)
2. Click on "Import" tab
3. Select the `database_setup.sql` file from the project root
4. Click "Import" to execute the script

**Or run manually:**
```sql
-- Open MySQL console and run:
mysql -u root -p < database_setup.sql
```

### Step 3: Verify Setup
The database `airtel_inventory` should be created with:
- `users` table with admin user (admin/admin123)
- `devices` table with 10 sample devices
- `employees` table with 5 sample employees
- `assignments` table for tracking device assignments

## 🏗 Project Structure

```
src/
├── main/
│   ├── java/com/airtel/inventory/
│   │   ├── AirtelInventoryApplication.java
│   │   ├── controller/
│   │   │   ├── LoginController.java
│   │   │   ├── DashboardController.java
│   │   │   └── DeviceController.java
│   │   ├── model/
│   │   │   ├── User.java
│   │   │   ├── Device.java
│   │   │   ├── Employee.java
│   │   │   └── Assignment.java
│   │   ├── repository/
│   │   │   ├── UserRepository.java
│   │   │   ├── DeviceRepository.java
│   │   │   ├── EmployeeRepository.java
│   │   │   └── AssignmentRepository.java
│   │   └── service/
│   │       └── DeviceService.java
│   └── resources/
│       ├── application.properties
│       ├── templates/
│       │   ├── login.html
│       │   ├── dashboard.html
│       │   └── devices/
│       │       ├── list.html
│       │       └── form.html
│       └── static/
│           └── css/
│               └── style.css
├── pom.xml
└── database_setup.sql
```

## 🚀 Running the Application

### Method 1: Using Eclipse IDE
1. Import the project as a Maven project
2. Right-click on the project
3. Select "Run As" → "Spring Boot App"
4. Wait for the application to start

### Method 2: Using Maven Command
```bash
mvn clean spring-boot:run
```

### Method 3: Using JAR File
```bash
mvn clean package
java -jar target/airtel-inventory-1.0.0.jar
```

## 🌐 Accessing the Application

Once the application starts, access it at:
**URL**: http://localhost:8081/airtel-inventory/login

**Login Credentials**:
- **Username**: 24RP01839
- **Password**: 24RP03971

> **Note**: These credentials are pre-configured in the database and displayed on the login page for easy access.

## 📱 Application Features

### 1. Login System
- Secure authentication with session management
- Automatic redirect to login if not authenticated
- Logout functionality

### 2. Dashboard
- Total devices count
- Available devices count
- Assigned devices count
- Availability rate percentage
- Quick access menu for all features

### 3. Device Management
- **View Devices**: List all devices with filtering and search
- **Add Device**: Register new equipment with detailed information
- **Delete Device**: Remove devices with confirmation
- **Search**: Find devices by asset tag, serial number, brand, or model

### 4. Device Information Tracked
- Asset Tag (unique identifier)
- Serial Number
- Device Type (Laptop/Desktop/Mobile)
- Brand and Model
- Specifications
- Condition (New/Good/Damaged/Repair/Retired)
- Status (Available/Assigned/Lost/Under Repair)
- Purchase Date and Warranty Period

## 🎨 UI/UX Features

- **Modern Design**: Clean, professional interface with Airtel branding
- **Responsive Layout**: Works seamlessly on desktop, tablet, and mobile
- **Status Indicators**: Color-coded badges for device status and condition
- **Interactive Elements**: Hover effects, smooth transitions
- **Search Bar**: Real-time search functionality
- **Confirmation Dialogs**: Safety confirmations for destructive actions

## 🔧 Configuration

### Application Properties
The application is configured in `src/main/resources/application.properties`:

```properties
# Server Configuration
server.port=8081
server.servlet.context-path=/airtel-inventory

# Database Configuration
spring.datasource.url=jdbc:mysql://localhost:3306/airtel_inventory
spring.datasource.username=root
spring.datasource.password=

# JPA Configuration
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true

# Thymeleaf Configuration
spring.thymeleaf.cache=false
```

## 🧪 Testing the Application

### Test Device Registration
1. Login as admin
2. Navigate to "Register Device"
3. Fill in device details:
   - Asset Tag: `LAP-TEST-001`
   - Serial Number: `SNTEST123456`
   - Device Type: `Laptop`
   - Brand: `Dell`
   - Model: `XPS 15`
4. Click "Register Device"

### Test Device Search
1. Go to device list
2. Enter search term (e.g., "Dell" or "LAP-001")
3. Verify filtered results

### Test Device Deletion
1. Select any device from the list
2. Click "Delete" button
3. Confirm deletion in dialog
4. Verify device is removed

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure MySQL is running in XAMPP
   - Verify database name: `airtel_inventory`
   - Check MySQL credentials in application.properties

2. **JPA Entity Errors**
   - Ensure all entity classes have `@Entity` annotation
   - Verify no `javax.persistence` imports (use `jakarta.persistence`)
   - Check that all repository interfaces extend `JpaRepository`

3. **Thymeleaf Template Errors**
   - Verify templates are in `src/main/resources/templates/`
   - Check file extensions are `.html`
   - Ensure proper Thymeleaf namespace in HTML

4. **Port Already in Use**
   - Change server port in application.properties
   - Stop other applications using port 8081

5. **CSS Not Loading**
   - Verify CSS file is in `src/main/resources/static/css/`
   - Check file path in HTML templates

### Database Issues

If you encounter database errors:
1. Drop and recreate the database:
   ```sql
   DROP DATABASE airtel_inventory;
   ```
2. Re-run the database setup script
3. Verify all tables and sample data are created

## 📊 Database Schema

### Users Table
- `id` - Primary key (auto-increment)
- `username` - Unique login username
- `password` - User password
- `full_name` - User's full name
- `role` - User role (admin/staff)

### Devices Table
- `id` - Primary key (auto-increment)
- `asset_tag` - Unique asset identifier
- `serial_number` - Manufacturer serial number
- `device_type` - Type of device
- `brand` - Device manufacturer
- `model` - Device model
- `specifications` - Technical specifications
- `device_condition` - Current condition
- `status` - Current status
- `purchase_date` - Date of purchase
- `warranty_until` - Warranty expiration date

### Employees Table
- `id` - Primary key (auto-increment)
- `employee_id` - Unique employee identifier
- `full_name` - Employee's full name
- `department` - Employee department
- `designation` - Job designation
- `email` - Email address
- `phone` - Phone number

### Assignments Table
- `id` - Primary key (auto-increment)
- `device_id` - Foreign key to devices
- `employee_id` - Foreign key to employees
- `assigned_date` - Assignment date
- `return_date` - Return date (null if still assigned)
- `notes` - Additional notes

## 🔐 Security Features

- Session-based authentication
- Automatic logout on session timeout
- Input validation and sanitization
- SQL injection prevention via JPA
- XSS protection in Thymeleaf templates

## 📈 Performance Considerations

- Database indexing on frequently queried fields
- Efficient JPA queries with proper fetch strategies
- Optimized CSS and minimal JavaScript
- Responsive design for mobile performance

## 🚀 Future Enhancements

The system is designed to accommodate future enhancements:
- Employee management module
- Device assignment tracking
- Reporting and analytics
- Barcode/QR code scanning
- Email notifications
- Audit logging
- Multi-tenant support

## 📞 Support

For any issues or questions:
1. Check the troubleshooting section above
2. Verify all prerequisites are met
3. Ensure database setup is complete
4. Check application logs for error messages

---

**Project Status**: ✅ Complete and Ready for Production Use

**Last Updated**: April 2026

**Version**: 1.0.0
