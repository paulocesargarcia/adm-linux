#!/bin/bash

for i in $(cut -d : -f 1 /etc/trueuserowners); do
    data_cron=$(crontab -l -u $i 2> /dev/null);
    total=$(echo $data_cron | wc -c);
    if [[ $total -gt 1 ]]; then
        echo "$i";
        echo "$data_cron";
    fi
done


# ns53 "bash <(curl -sk https://raw.githubusercontent.com/paulocesargarcia/adm-linux/main/cronjob-list.sh)" > ns53-log.txt
