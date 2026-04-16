# 🚀 Running Multiple Databases with Docker Compose

This project supports **PostgreSQL, MySQL, and H2** databases. You can run all databases simultaneously using Docker Compose.

## Quick Start (All Databases at Once)

### Linux / macOS / Git Bash (Windows)

```bash
chmod +x clean-and-run.sh
./clean-and-run.sh
```

This script will:
- ✅ Kill any running Java processes
- ✅ Stop and clean Docker containers
- ✅ Build MySQL Docker image
- ✅ Start all databases (PostgreSQL + MySQL)
- ✅ Verify database connections
- ✅ Build the project
- ✅ Start the application with PostgreSQL

### Windows CMD

```cmd
docker-compose -f docker-compose-full.yml up -d
timeout /t 10 /nobreak
gradlew clean build -x test
gradlew bootRun
```

---

## Running with Different Databases

Once all databases are running, you can switch between them:

### PostgreSQL (Default)
```bash
./run-postgres.sh
```
Or:
```bash
./gradlew bootRun
```

### MySQL
```bash
./run-mysql.sh
```
Or:
```bash
./gradlew bootRun --args='--spring.profiles.active=mysql'
```

### H2 (In-Memory)
```bash
./run-h2.sh
```
Or:
```bash
./gradlew bootRun --args='--spring.profiles.active=h2'
```

> **Tip:** Run these in separate terminals to keep all databases active!

---

## Managing Databases

### View running containers
```bash
docker-compose -f docker-compose-full.yml ps
```

### Stop all databases
```bash
docker-compose -f docker-compose-full.yml down
```

### Start all databases again
```bash
docker-compose -f docker-compose-full.yml up -d
```

### View logs
```bash
docker-compose -f docker-compose-full.yml logs -f
```

### Connect to PostgreSQL
```bash
docker exec flowers-postgres psql -U admin -d flowersdb
```

### Connect to MySQL
```bash
docker exec flowers-mysql mysql -u admin -psecret -D flowersdb
```

---

## Database Connections

| Database | Host | Port | User | Password | Notes |
|----------|------|------|------|----------|-------|
| **PostgreSQL** | localhost | 5432 | admin | secret | Persistent |
| **MySQL** | localhost | 3306 | admin | secret | Persistent |
| **H2** | In-Memory | - | sa | (empty) | Resets on restart |

---

## API Endpoints

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

## H2 Console

When running with H2 profile, access the H2 console at:
- **URL:** http://localhost:8080/h2-console
- **JDBC URL:** jdbc:h2:mem:testdb
- **User:** sa
- **Password:** (leave empty)

---

## Docker Compose File

The main configuration file is `docker-compose-full.yml` which includes:
- PostgreSQL with volume persistence
- MySQL with auto-build from Dockerfile
- Health checks for both databases
- Proper dependency ordering

---

## Troubleshooting

### Port already in use
```bash
# Kill Java processes
pkill -f java

# Or specific port (Linux/macOS)
lsof -i :8080 | grep -v COMMAND | awk '{print $2}' | xargs kill -9
```

### Docker build fails
```bash
# Force rebuild MySQL image
docker build -t flowers-mysql -f Dockerfile.mysql . --no-cache
```

### Database connection refused
```bash
# Ensure containers are running
docker ps

# Check logs
docker logs flowers-postgres
docker logs flowers-mysql
```

### Data not persisting in MySQL/PostgreSQL
- PostgreSQL data is stored in Docker volume `postgres_data`
- MySQL data is stored in Docker volume created by mysql service
- Both persist until you run `docker-compose down -v`

---

## Project Files

- **docker-compose-full.yml** - Main compose file with all services
- **clean-and-run.sh** - Complete setup and run script
- **run-postgres.sh** - Run with PostgreSQL
- **run-mysql.sh** - Run with MySQL
- **run-h2.sh** - Run with H2
- **Dockerfile.mysql** - MySQL image definition
- **init.sql** - PostgreSQL initialization
- **init-mysql.sql** - MySQL initialization
- **application-mysql.properties** - MySQL configuration
- **application-h2.properties** - H2 configuration
