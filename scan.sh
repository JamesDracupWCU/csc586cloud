#!/bin/bash
login="/var/log/auth.log"
failedip=$(grep "Invalid user" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
for ip in $failedip; do
        date=$(grep "$ip" "$login" | awk '{print $1, $2, $3}' | head -n 1)
   if ! grep -q "$ip" "/var/webserver_log/unauthorized.log"; then
     if ! grep -q "$date" "/var/webserver_log/unauthorized.log"; then
        country=$(sudo geoiplookup $ip | awk -F ', ' '{print $2}')
        echo "IP: $ip, Country: $country, Date: $date"
        echo "IP: $ip, Country: $country, Date: $date" >> "/var/webserver_log/unauthorized.log"
     fi 
   fi
done
