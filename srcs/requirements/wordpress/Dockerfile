FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install netcat curl php-fpm php-cli php-mysql php-curl php-gd php-intl -y

RUN mkdir -p /var/www
RUN mkdir -p /run/php

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY tools/entrypoint.sh .
RUN chmod +x entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["./entrypoint.sh"]

CMD ["php-fpm7.4", "-F"]
