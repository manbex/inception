#!/bin/sh

if [ -d "/var/www/wordpress" ]
then
	echo wordpress already installed
else
	curl -O https://wordpress.org/latest.tar.gz
	tar -xf latest.tar.gz
	rm latest.tar.gz
	mv wordpress /var/www/
	chmod -R 755 /var/www/wordpress

	cp /var/www/wordpress/wp-config-sample.php /var/www/wordpress/wp-config.php
	sed -i "s/username_here/$MYSQL_USER/g" /var/www/wordpress/wp-config.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" /var/www/wordpress/wp-config.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" /var/www/wordpress/wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" /var/www/wordpress/wp-config.php
fi

exec "$@"
