#!/bin/bash

log="/var/webserver_monitor/unauthorized.log"
admin_email="jamesdracup16@gmail.com"

if [ -f "$log" ]; then
    current=$(cat location.txt || echo 0)
    new=$(tail -c +$((current + 1)) "$log")

    if [ -n "$new" ]; then
        echo "$new" | mail -s "New Unauthorized/Failed Access Attempts Detected" "$admin_email"
        echo "$(wc -l < "$log")" > location.txt
    else
        echo "No Unauthorized/Failed Access Attempts." | mail -s "No Unauthorized/Failed Access Attempts" "$admin_email"
    fi
else
    echo "Log file not found: $log"
fi
