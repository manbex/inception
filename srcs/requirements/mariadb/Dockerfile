FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install mariadb-server -y

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

COPY tools/entrypoint.sh entrypoint.sh
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]
CMD ["mysqld"]

