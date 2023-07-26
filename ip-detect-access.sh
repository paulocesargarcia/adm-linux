#!/bin/bash

get_process_name() {
    local pid=$1
    ps -p "$pid" -o comm= || echo "N/A"
}

get_username() {
    local pid=$1
    local uid=$(stat -c %u "/proc/$pid" 2>/dev/null)
    [ -n "$uid" ] && getent passwd "$uid" | cut -d: -f1 || echo "N/A"
}

main() {
    echo "Local IP       Port       Remote IP        Port          PID     Name             User"
    echo "---------------------------------------------------------------------------------------"
    LC_ALL=C ss -tapns | grep "$(hostname -I | cut -d' ' -f1)" | grep httpd | awk '{print $5, $6, $7}' | while read local remote pid; do
        local_ip=$(echo "$local" | awk -F: '{print $1}')
        local_port=$(echo "$local" | awk -F: '{print $NF}')
        remote_ip=$(echo "$remote" | awk -F: '{print $1}')
        remote_port=$(echo "$remote" | awk -F: '{print $NF}')
        process_name=$(get_process_name $pid)
        user=$(get_username $pid)
        printf "%-15s%-11s%-18s%-13s%-7s%-18s%s\n" "$local_ip" "$local_port" "$remote_ip" "$remote_port" "$pid" "$process_name" "$user"
    done
}

if [ $EUID -eq 0 ]; then
    main
else
    echo "Este script requer privilégios de superusuário (root). Execute-o com 'sudo'."
fi
