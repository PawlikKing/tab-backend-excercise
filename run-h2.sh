#!/bin/bash

# Run with H2 profile
echo "🚀 Starting application with H2 (In-Memory)..."
echo "💡 H2 Console available at: http://localhost:8080/h2-console"
./gradlew bootRun --args='--spring.profiles.active=h2'
