#!/bin/bash

# Run with MySQL profile
echo "🚀 Starting application with MySQL..."
./gradlew bootRun --args='--spring.profiles.active=mysql'
