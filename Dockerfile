# Use OpenJDK 17 JRE as base image
FROM eclipse-temurin:17-jre-alpine

# Install MySQL client for database connectivity
RUN apk add --no-cache mysql-client

# Set working directory
WORKDIR /app

# Copy the pre-built JAR file
COPY target/airtel-inventory-1.0.0.jar app.jar

# Expose port
EXPOSE 8080

# Set environment variables
ENV JAVA_OPTS="-Xmx512m -Xms256m"
ENV SPRING_PROFILES_ACTIVE=production

# Run the application
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar --server.port=$PORT"]
