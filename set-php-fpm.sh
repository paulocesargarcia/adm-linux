versions=("ea-php73" "ea-php74" "ea-php80" "ea-php81" "ea-php82")

for version in "${versions[@]}"
do
  whmapi1 php_ini_set_directives \
    directive-1='allow_url_fopen:1' \
    directive-3='display_errors:1' \
    directive-4='file_uploads:1' \
    directive-5='memory_limit:512M' \
    directive-6='post_max_size:512M' \
    directive-7='upload_max_filesize:512M' \
    directive-8='zlib.output_compression:1' \
    version="$version"
done
/scripts/restartsrv_apache_php_fpm