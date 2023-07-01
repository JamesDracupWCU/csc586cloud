#!/bin/bash
 2 login="/var/log/auth.log"
 3 failedip=$(grep "Invalid user" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
 4 for ip in $failedip; do
 5         date=$(grep "$ip" "$login" | awk '{print $1, $2,"'$(date +'%Y')'", $3}' | head -n 1)
 6    if ! grep -q "$ip" "/var/webserver_log/unauthorized.log"; then
 7         country=$(sudo geoiplookup $ip | awk -F ', ' '{print $2}')
 8        printf "IP: %-19s Country: %-19s Date: %s\n" "$ip" "$country" "$date"
 9        printf "IP: %-19s Country: %-19s Date: %s\n" "$ip" "$country" "$date" >> "/var/webserver_log/unauthorized.log"
10    fi
11 done
