## Multi-Database Support Setup Guide

This Spring Boot application now supports **three different databases**: PostgreSQL, MySQL, and H2.

### Quick Start

#### 1. PostgreSQL (Default)
```bash
# Start PostgreSQL container
docker-compose up -d

# Run application (uses default profile)
./gradlew bootRun
```
Access API on `http://localhost:8080`

---

#### 2. MySQL
```bash
# Build MySQL Docker image
docker build -t flowers-mysql -f Dockerfile.mysql .

# Run MySQL container
docker run -d -e MYSQL_PASSWORD=secret -e MYSQL_ROOT_PASSWORD=root -e MYSQL_USER=admin \
  --name flowers-mysql -p 3306:3306 flowers-mysql

# Run application with MySQL profile
./gradlew bootRun --args='--spring.profiles.active=mysql'
```
Access API on `http://localhost:8080`
- Database: MySQL on port 3306
- User: admin / secret

---

#### 3. H2 (In-Memory)
```bash
# Run application with H2 profile
./gradlew bootRun --args='--spring.profiles.active=h2'
```
Access API on `http://localhost:8080`
- H2 Console: `http://localhost:8080/h2-console`
- Username: sa
- Password: (empty)

> **Note:** H2 data is stored in-memory and will be lost on restart

---

### File Structure

- **application.properties** - PostgreSQL configuration (default)
- **application-mysql.properties** - MySQL configuration
- **application-h2.properties** - H2 configuration
- **schema.sql** - Database schema (for H2 auto-creation)
- **data.sql** - Test data (for H2 auto-initialization)
- **init-mysql.sql** - MySQL initialization script
- **Dockerfile.mysql** - MySQL container definition

---

### Testing Endpoints

```bash
# Get all flowers
curl http://localhost:8080/flowers

# Get user's favorite flower
curl http://localhost:8080/flowers/fav/users/Kamil

# Update user's favorite flower
curl -X POST http://localhost:8080/flowers/fav/users/Kamil \
  -H "Content-Type: application/json" \
  -d '{"name":"Lilia"}'
```

---

### Database Comparison

| Feature | PostgreSQL | MySQL | H2 |
|---------|-----------|-------|-----|
| Port | 5432 | 3306 | Memory |
| Container | docker-compose | Dockerfile.mysql | None |
| Data Persistence | Yes | Yes | No (in-memory) |
| Production-Ready | ✅ | ✅ | ⚠️ (testing only) |
| Profile | default | mysql | h2 |

---

### Switching Databases

To switch databases, simply change the `--spring.profiles.active` parameter and ensure the corresponding database is running.
