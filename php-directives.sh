#!/bin/bash

# Lista de versões do PHP disponíveis no servidor
versions=("ea-php56" "ea-php70" "ea-php71" "ea-php72" "ea-php73" "ea-php74" "ea-php80" "ea-php81")

# Loop através das versões e configure as diretivas PHP para cada uma
for version in "${versions[@]}"
do
  whmapi1 php_ini_set_directives \
    directive-1='allow_url_fopen:1' \
    directive-3='display_errors:1' \
    directive-4='file_uploads:1' \
    directive-5='memory_limit:256M' \
    directive-6='post_max_size:256M' \
    directive-7='upload_max_filesize:256M' \
    directive-8='zlib.output_compression:1' \
    version="$version"
done

# bash <(curl -sk https://raw.githubusercontent.com/paulocesargarcia/adm-linux/main/php-directives.sh)
