#!/bin/bash
Login="/var/log/auth.log"
unauthorized_login="/var/webserver_log/unauthorized.log"
failedAttempts=$(grep "Failed password" "$Login")

#To edit Cron
#crontab -e and then modify it for every 5 minutes it should execute the scan.sh /_/_/scan.sh
