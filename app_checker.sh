#!/bin/bash

# -----------------------------
# Application Health Checker
# -----------------------------
# Log file
LOGFILE="/mnt/c/Users/ramya/Assessment/scripts/app_health.log"

# List of application URLs to monitor
APPS=(
    "http://example.com"
    "http://localhost:8080"
    # Add more URLs here if needed
)

# Get current timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Function to check one app
check_app() {
    local URL=$1
    STATUS_CODE=$(curl -o /dev/null -s -w "%{http_code}" "$URL")

    if [ "$STATUS_CODE" -eq 200 ]; then
        echo "[$TIMESTAMP] ✅ $URL is UP (200 OK)" | tee -a "$LOGFILE"
    else
        echo "[$TIMESTAMP] ❌ $URL is DOWN (Status Code: $STATUS_CODE)" | tee -a "$LOGFILE"
    fi
}

# Loop through all apps and check each one
for APP in "${APPS[@]}"; do
    check_app "$APP"
done
