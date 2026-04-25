@echo off
echo Setting JAVA_HOME...
set JAVA_HOME=C:\Program Files\Java\jdk-21
echo JAVA_HOME set to: %JAVA_HOME%
echo.
echo Building project...
call .\mvnw.cmd clean package -DskipTests
echo.
echo Build completed!
