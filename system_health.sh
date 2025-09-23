#!/bin/bash

# ==============================
# System Health Monitoring Script
# ==============================

# Thresholds
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=80

# Log file
LOGFILE="/var/log/system_health.log"

# Timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Function to log alerts
log_alert() {
    echo "[$TIMESTAMP] $1" | tee -a "$LOGFILE"
}

# ---- CPU Usage ----
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_USAGE=${CPU_USAGE%.*}  # remove decimal

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    log_alert "⚠️CPU usage is high: $CPU_USAGE%"
else
    echo " CPU usage is normal: $CPU_USAGE%"
fi

# ---- Memory Usage ----
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
MEM_USAGE=${MEM_USAGE%.*}

if [ "$MEM_USAGE" -gt "$MEM_THRESHOLD" ]; then
    log_alert "⚠️Memory usage is high: $MEM_USAGE%"
else
    echo " Memory usage is normal: $MEM_USAGE%"
fi

# ---- Disk Usage ----
DISK_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
    log_alert " Disk usage is high: $DISK_USAGE%"
else
    echo " Disk usage is normal: $DISK_USAGE%"
fi

# ---- Top 5 Processes by CPU ----
echo " Top 5 processes by CPU usage:" | tee -a "$LOGFILE"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | tee -a "$LOGFILE"
echo "----------------------------------------"
