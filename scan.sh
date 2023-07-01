#!/bin/bash
  login="/var/log/auth.log"
  failedip=$(grep "Invalid user" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
  for ip in $failedip; do
          date=$(grep "$ip" "$login" | awk '{print $1, $2,"'$(date +'%Y')'", $3}' | head -n 1)
     if ! grep -q "$ip" "/var/webserver_log/unauthorized.log"; then
        if [[ $ip == "103.176.96.74" ]]; then
            country="Indonesia"
        elif [[ $ip == "103.149.28.105" ]]; then
            country="Vietnam"
        else
            country=$(sudo geoiplookup $ip | awk -F ', ' '{print $2}')
        fi
            printf "IP: %-19s Country: %-19s Date: %s\n" "$ip" "$country" "$date"
            printf "IP: %-19s Country: %-19s Date: %s\n" "$ip" "$country" "$date" >> "/var/webserver_log/unauthorized.log"
     fi
  done
