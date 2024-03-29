#!/bin/bash

OUTPUT_FILE="senhas_usuarios_cpanel.txt"
USERS=$(cat /etc/trueuserowners | cut -d: -f1)

for USER in $USERS; do
    # Ignorar o usuario "root"
    if [ "$USER" != "root" ]; then
        NEW_PASSWORD=$(openssl rand -base64 12)
        whmapi1 passwd user="$USER" password="$NEW_PASSWORD"
        DOMAIN=$(whmapi1 accountsummary user="$USER" | grep "domain:" | awk '{print $2}')
        echo "Dominio: $DOMAIN, Usuario: $USER, Senha: $NEW_PASSWORD" >> "$OUTPUT_FILE"
        echo "Senha alterada para $USER"
    else
        echo "Ignorando usuario root."
    fi
done

echo "Concluido. Dados salvos em $OUTPUT_FILE"



# bash <(curl -sk https://raw.githubusercontent.com/paulocesargarcia/adm-linux/main/passwd-whm-all.sh)