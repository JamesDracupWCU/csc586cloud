#!/bin/bash
login="/var/log/auth.log"
failed=$(grep "sshd" "$login" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
for ip in $failed; do
        country=$(curl -s "https://ipinfo.io/$ip/country" | tr -d '"')
        echo "IP: $ip, Country: $country"
        echo "IP: $ip, Country: $country" >> "/var/webserver_log/unauthorized.log"
done
#To edit Cron
#crontab -e and then modify it for every 5 minutes it should execute the scan.sh /_/_/scan.sh
