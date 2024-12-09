#!/bin/sh

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then
	echo Database $MYSQL_DATABASE exists
else
	service mariadb start

	sleep 2

	mariadb -uroot -p$MYSQL_ROOT_PASSWORD << _EOF_
	DELETE FROM mysql.user WHERE User='';
	DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
	DROP DATABASE IF EXISTS test;
	DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
	CREATE DATABASE $MYSQL_DATABASE;
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	FLUSH PRIVILEGES;
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER' IDENTIFIED BY '$MYSQL_PASSWORD';
	FLUSH PRIVILEGES;
_EOF_

	echo Database $MYSQL_DATABASE created
	mysqladmin -uroot -p$MYSQL_ROOT_PASSWORD shutdown
fi

exec "$@"
