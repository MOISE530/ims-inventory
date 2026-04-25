@echo off
echo =================================
echo Starting IMS - Inventory Management System
echo =================================

REM Set Java Home
set JAVA_HOME=C:\Program Files\Java\jdk-21

REM Add Maven to PATH
set PATH=%PATH%;.\apache-maven-3.9.4\bin

echo Java Home: %JAVA_HOME%
echo Maven Path: .\apache-maven-3.9.4\bin
echo.
echo Starting application on port 8081...
echo Access URL: http://localhost:8081/airtel-inventory/login
echo Username: admin
echo Password: admin123
echo.
echo Press Ctrl+C to stop the application
echo.

REM Start the application
.\apache-maven-3.9.4\bin\mvn.cmd spring-boot:run

pause
