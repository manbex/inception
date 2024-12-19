#!/bin/sh

if [ -d "/var/www/wordpress" ]
then
	echo wordpress already installed
else
	mkdir -p /var/www/wordpress
	cd /var/www/wordpress
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	sleep 2
	wp core download --allow-root
	wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --allow-root
	wp core install --url=$WP_URL --title="$WP_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	wp user create $WP_USER $WP_EMAIL --user_pass=$WP_PASSWORD --allow-root

fi

exec "$@"
