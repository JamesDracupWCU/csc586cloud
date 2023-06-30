#!/bin/bash

log="/var/webserver_monitor/unauthorized.log"
#Actual email to be notified every hour if new unauthorized attempts occur in the 5-minute intervals or not.
admin_email="jamesdracup16@gmail.com"

if [ -f "$log" ]; then
    current=$(cat location.txt || echo 0)
    new=$(tail -c +$((current + 1)) "$log")

    if [ -n "$new" ]; then
        echo "$new" | mail -s "New Unauthorized Access Detected:" "$admin_email"
        echo "$(wc -l < "$log")" > location.txt
    else
        echo "No unauthorized access." | mail -s "No unauthorized access" "$admin_email"
    fi
else
