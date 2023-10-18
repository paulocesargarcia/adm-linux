#!/bin/bash

for i in $(cut -d : -f 1 /etc/trueuserowners); do
    data_cron=$(crontab -l -u $i 2> /dev/null);
    total=$(echo $data_cron | wc -c);
    if [[ $total -gt 1 ]]; then
        echo "$i";
        echo "$data_cron";
    fi
done
