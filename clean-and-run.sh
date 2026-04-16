#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🧹 Cleaning up Java processes and Docker containers...${NC}"

# Kill all Java processes
echo -e "${YELLOW}Killing Java processes...${NC}"
pkill -f "java" 2>/dev/null || echo "No Java processes found"

# Stop MySQL container
echo -e "${YELLOW}Stopping MySQL container...${NC}"
docker stop flowers-mysql 2>/dev/null || echo "MySQL not running"

# Stop PostgreSQL via docker-compose
echo -e "${YELLOW}Stopping PostgreSQL via docker-compose...${NC}"
docker-compose down 2>/dev/null || echo "docker-compose down failed"

# Remove unused containers
echo -e "${YELLOW}Cleaning up unused containers...${NC}"
docker container prune -f 2>/dev/null || echo "No containers to prune"

# Wait a bit
sleep 2

echo -e "${GREEN}✓ Cleanup complete${NC}"

# Start PostgreSQL
echo -e "${YELLOW}🚀 Starting PostgreSQL container...${NC}"
docker-compose up -d

# Wait for database to start
echo -e "${YELLOW}Waiting for database to initialize...${NC}"
sleep 5

# Verify connection
echo -e "${YELLOW}Verifying database connection...${NC}"
docker exec tab-backend-excercise-postgres-1 psql -U admin -d flowersdb -c "SELECT COUNT(*) FROM flowers;" 2>/dev/null && echo -e "${GREEN}✓ PostgreSQL ready${NC}" || echo -e "${RED}✗ Database connection failed${NC}"

# Rebuild project
echo -e "${YELLOW}📦 Building project...${NC}"
./gradlew clean build -x test

# Run application
echo -e "${GREEN}✅ Starting application with PostgreSQL${NC}"
echo -e "${YELLOW}Available endpoints:${NC}"
echo "  GET  http://localhost:8080/flowers"
echo "  GET  http://localhost:8080/flowers/fav/users/{name}"
echo "  POST http://localhost:8080/flowers/fav/users/{name}"
echo ""
echo -e "${YELLOW}To use MySQL:${NC}"
echo "  ./gradlew bootRun --args='--spring.profiles.active=mysql'"
echo ""
echo -e "${YELLOW}To use H2:${NC}"
echo "  ./gradlew bootRun --args='--spring.profiles.active=h2'"
echo ""

./gradlew bootRun
