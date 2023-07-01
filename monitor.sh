#!/bin/bash

log="/var/webserver_monitor/unauthorized.log"
admin_email="jamesdracup16@gmail.com"
previous_append=$(cat "/var/webserver_monitor/previous_append.txt" 2>/dev/null)

current_append=$(cat "$log")

if [ -s "$log" ] && [ "$current_append" != "$previous_append" ]; then
    echo -e "New Unauthorized Access:\n\n$current_append" | mail -s "New Unauthorized Access" "$admin_email"
    echo "$current_append" > "/var/webserver_monitor/previous_append.txt"
else
    echo -e "No Unauthorized Access" | mail -s "No Unauthorized Access" "$admin_email"
fi
