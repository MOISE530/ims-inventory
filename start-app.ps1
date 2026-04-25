# IMS - Inventory Management System Startup Script
Write-Host "=================================" -ForegroundColor Green
Write-Host "Starting IMS - Inventory Management System" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# Set Java Home
$env:JAVA_HOME = "C:\Program Files\Java\jdk-21"

# Add Maven to PATH
$env:PATH = "$env:PATH;.\apache-maven-3.9.4\bin"

Write-Host "Java Home: $env:JAVA_HOME" -ForegroundColor Yellow
Write-Host "Maven Path: .\apache-maven-3.9.4\bin" -ForegroundColor Yellow
Write-Host ""
Write-Host "Starting application on port 8081..." -ForegroundColor Cyan
Write-Host "Access URL: http://localhost:8081/airtel-inventory/login" -ForegroundColor Cyan
Write-Host "Username: admin" -ForegroundColor Cyan
Write-Host "Password: admin123" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the application" -ForegroundColor Red
Write-Host ""

# Start the application
.\apache-maven-3.9.4\bin\mvn.cmd spring-boot:run
