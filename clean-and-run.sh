#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🧹 Cleaning up Java processes and Docker containers...${NC}"

# Kill all Java processes
echo -e "${YELLOW}Killing Java processes...${NC}"
pkill -f "java" 2>/dev/null || echo "No Java processes found"

# Stop all docker-compose services
echo -e "${YELLOW}Stopping Docker containers...${NC}"
docker-compose down 2>/dev/null || echo "docker-compose down failed"
docker-compose -f docker-compose-full.yml down 2>/dev/null || echo "docker-compose-full down failed"

# Remove unused containers
echo -e "${YELLOW}Cleaning up unused containers...${NC}"
docker container prune -f 2>/dev/null || echo "No containers to prune"

# Wait a bit
sleep 2

echo -e "${GREEN}✓ Cleanup complete${NC}"
echo ""

# Build MySQL image if needed
echo -e "${YELLOW}🔨 Building MySQL Docker image...${NC}"
docker build -t flowers-mysql -f Dockerfile.mysql . 2>/dev/null || echo "MySQL image already exists"

# Start all databases
echo -e "${YELLOW}🚀 Starting all databases (PostgreSQL, MySQL, H2)...${NC}"
docker-compose -f docker-compose-full.yml up -d

# Wait for databases to start
echo -e "${YELLOW}⏳ Waiting for databases to initialize...${NC}"
sleep 8

# Verify connections
echo -e "${YELLOW}✓ Verifying database connections...${NC}"
docker exec flowers-postgres psql -U admin -d flowersdb -c "SELECT COUNT(*) as flowers FROM flowers;" 2>/dev/null && echo -e "${GREEN}✓ PostgreSQL (5432) ready${NC}" || echo -e "${RED}✗ PostgreSQL failed${NC}"
docker exec flowers-mysql mysql -u admin -psecret -e "SELECT COUNT(*) as flowers FROM flowersdb.flowers;" 2>/dev/null && echo -e "${GREEN}✓ MySQL (3306) ready${NC}" || echo -e "${RED}✗ MySQL failed${NC}"

# Rebuild project
echo -e "${YELLOW}📦 Building project...${NC}"
./gradlew clean build -x test

echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ All databases are running!${NC}"
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${YELLOW}📋 Choose how to run the application:${NC}"
echo ""
echo -e "${GREEN}1. PostgreSQL (DEFAULT) - Run now:${NC}"
echo "   ./gradlew bootRun"
echo ""
echo -e "${GREEN}2. MySQL - In another terminal:${NC}"
echo "   ./gradlew bootRun --args='--spring.profiles.active=mysql'"
echo ""
echo -e "${GREEN}3. H2 (In-Memory) - In another terminal:${NC}"
echo "   ./gradlew bootRun --args='--spring.profiles.active=h2'"
echo ""
echo -e "${YELLOW}📡 API Endpoints:${NC}"
echo "   GET  http://localhost:8080/flowers"
echo "   GET  http://localhost:8080/flowers/fav/users/{name}"
echo "   POST http://localhost:8080/flowers/fav/users/{name}"
echo ""
echo -e "${YELLOW}🗄️  Database Connections:${NC}"
echo "   PostgreSQL: localhost:5432 (admin/secret)"
echo "   MySQL:      localhost:3306 (admin/secret)"
echo "   H2 Console: http://localhost:8080/h2-console (when using h2 profile)"
echo ""
echo -e "${BLUE}════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "${GREEN}🚀 Starting application with PostgreSQL...${NC}"
echo ""

./gradlew bootRun

