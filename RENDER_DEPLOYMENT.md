# Render Deployment Guide
## Airtel Inventory Management System

This guide provides step-by-step instructions for deploying the Airtel Inventory Management System to Render.

### 🚀 Prerequisites

1. **Render Account**: Create a free account at [render.com](https://render.com)
2. **GitHub Repository**: Push your code to a GitHub repository
3. **Git Installed**: Ensure Git is installed on your local machine

### 📋 Deployment Steps

#### 1. Prepare Your Repository

```bash
# Initialize Git repository (if not already done)
git init
git add .
git commit -m "Initial commit: Airtel Inventory System"

# Create GitHub repository and push
git remote add origin https://github.com/yourusername/airtel-inventory.git
git branch -M main
git push -u origin main
```

#### 2. Deploy to Render

1. **Login to Render Dashboard**
2. **Click "New +" → "Web Service"**
3. **Connect GitHub Repository**
   - Select your `airtel-inventory` repository
   - Choose the `main` branch

#### 3. Configure Web Service

**Basic Configuration:**
- **Name**: `airtel-inventory`
- **Environment**: `Java`
- **Region**: Choose nearest region
- **Branch**: `main`

**Build Configuration:**
- **Build Command**: `./mvnw clean package -DskipTests`
- **Start Command**: `java -jar target/airtel-inventory-1.0.0.jar`

**Advanced Settings:**
- **Health Check Path**: `/airtel-inventory/login`
- **Auto-Deploy**: Enabled (recommended)

#### 4. Set Up Database

1. **Create PostgreSQL Database**
   - Click "New +" → "PostgreSQL"
   - **Name**: `airtel-inventory-db`
   - **Database Name**: `airtel_inventory`
   - **User**: `airtel_user`

2. **Configure Database Environment Variables**
   Render automatically provides these environment variables:
   - `DATABASE_URL`
   - `DATABASE_USER`
   - `DATABASE_PASSWORD`

#### 5. Add Environment Variables

In your Web Service settings, add these environment variables:

```bash
JAVA_VERSION=17
SPRING_PROFILES_ACTIVE=production
```

#### 6. Initialize Database

1. **Access PostgreSQL Shell** from Render dashboard
2. **Run the setup script**:
   ```sql
   -- Copy contents from database_setup_postgresql.sql
   -- Paste and execute in the PostgreSQL shell
   ```

#### 7. Deploy and Test

1. **Manual Deploy**: Click "Manual Deploy" in Render dashboard
2. **Wait for Build**: Monitor the build logs
3. **Test Application**: Access your deployed app at `https://airtel-inventory.onrender.com/airtel-inventory/login`

### 🔧 Configuration Files

#### render.yaml
```yaml
services:
  type: web
  name: airtel-inventory
  env: java
  buildCommand: ./mvnw clean package -DskipTests
  startCommand: java -jar target/airtel-inventory-1.0.0.jar
  healthCheckPath: /airtel-inventory/login
  envVars:
    - key: JAVA_VERSION
      value: 17
    - key: SPRING_PROFILES_ACTIVE
      value: production

databases:
  - name: airtel-inventory-db
    databaseName: airtel_inventory
    user: airtel_user
```

#### Procfile
```
web: java -jar target/airtel-inventory-1.0.0.jar --server.port=$PORT
```

### 🌐 Access Information

After deployment:
- **Application URL**: `https://your-service-name.onrender.com/airtel-inventory/login`
- **Username**: `24RP01839`
- **Password**: `24RP03971`

### 🔍 Troubleshooting

#### Common Issues

1. **Build Fails**
   - Check Maven dependencies
   - Verify Java version compatibility
   - Review build logs in Render dashboard

2. **Database Connection Error**
   - Verify database is running
   - Check environment variables
   - Ensure PostgreSQL driver is included

3. **404 Errors**
   - Verify context path configuration
   - Check health check path
   - Review routing in controllers

4. **Application Not Starting**
   - Check start command
   - Verify JAR file exists
   - Review application logs

#### Debug Commands

```bash
# Check Maven build locally
./mvnw clean package

# Test application locally
java -jar target/airtel-inventory-1.0.0.jar

# Check database connection
psql $DATABASE_URL
```

### 📊 Monitoring

Render provides built-in monitoring:
- **Metrics**: CPU, Memory, Network
- **Logs**: Application and system logs
- **Health Checks**: Automated health monitoring
- **Alerts**: Email notifications for issues

### 🔒 Security Considerations

1. **Environment Variables**: Store sensitive data in environment variables
2. **HTTPS**: Render provides automatic SSL certificates
3. **Database**: Use Render's built-in PostgreSQL with connection pooling
4. **Session Security**: Production config includes secure cookie settings

### 💰 Cost Estimate

- **Free Tier**: Available for hobby projects
- **Web Service**: ~$7/month (beyond free tier)
- **PostgreSQL**: ~$7/month (beyond free tier)
- **Total**: ~$14/month for production deployment

### 🚀 Performance Optimization

1. **Connection Pooling**: Configured in production properties
2. **Caching**: Thymeleaf cache enabled
3. **Logging**: Reduced for production
4. **Health Checks**: Configured for monitoring

### 📝 Post-Deployment Checklist

- [ ] Application loads successfully
- [ ] Login functionality works
- [ ] Database operations work
- [ ] All pages render correctly
- [ ] Mobile responsive design works
- [ ] Error handling functions
- [ ] Health checks pass
- [ ] Logs are accessible

### 🔄 Updates and Maintenance

1. **Code Updates**: Push to GitHub → Auto-deploy
2. **Database Changes**: Use migration scripts
3. **Configuration**: Update environment variables
4. **Monitoring**: Check Render dashboard regularly

---

**Ready for Production!** 🎉

Your Airtel Inventory Management System is now configured for professional deployment on Render with all the necessary production optimizations and security measures.
