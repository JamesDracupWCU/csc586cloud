#!/bin/bash
login="/var/log/auth.log"
failedip=$(grep "Invalid user" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
for ip in $failedip; do
        date=$(grep "$ip" "$login" | awk '{print $1, $2,"'$(date +'%Y')'", $3}' | head -n 1)
   if ! grep -q "$ip" "/var/webserver_log/unauthorized.log"; then
        country=$(sudo geoiplookup $ip | awk -F ', ' '{print $2}')
       printf "IP: %-17s Country: %-19s Date: %s\n" "$ip" "$country" "$date"
       printf "IP: %-17s Country: %-19s Date: %s\n" "$ip" "$country" "$date" >> "/var/webserver_log/unauthorized.log"
   fi
done
