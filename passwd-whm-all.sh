#!/bin/bash

OUTPUT_FILE="senhas_usuarios_cpanel.txt"
USERS=$(whmapi1 list_users | grep "user:" | awk '{print $2}')

for USER in $USERS; do
    NEW_PASSWORD=$(openssl rand -base64 12)
    #whmapi1 passwd user="$USER" password="$NEW_PASSWORD"
    DOMAIN=$(whmapi1 accountsummary user="$USER" | grep "domain:" | awk '{print $2}')
    echo "Domínio: $DOMAIN, Usuário: $USER, Senha: $NEW_PASSWORD" >> "$OUTPUT_FILE"
    echo "Senha alterada para $USER"
done

echo "Concluído. Dados salvos em $OUTPUT_FILE"
