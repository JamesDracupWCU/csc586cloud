#!/bin/bash
login="/var/log/auth.log"
failed=$(grep "Invalid user" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
for ip in $failed; do
#got rid of country after / tr -d
        date=$(grep "$ip" "$login" | awk '{print  $1" "  $2" " $3" " }' | head -n 1 )
        country=$(sudo geoiplookup $ip | awk -F ', ' '{print $2}')
 #  country=$(curl -s https://ipinfo.io/$ip/ | tr -d )
        echo "IP: $ip, Country: $country,   Date: $date"
        echo "IP: $ip, Country: $country,   Date: $date" >> "/var/webserver_log/unauthorized.log"
done
