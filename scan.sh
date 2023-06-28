#!/bin/bash
Login="/var/log/auth.log"
unauthorized_login="/var/webserver_log/unauthorized.log"
failedAttempts=$(grep "Failed password" "$Login")
