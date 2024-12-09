FROM debian:bullseye

RUN apt update -y
RUN apt upgrade -y
RUN apt install nginx openssl -y

RUN mkdir /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=FR/ST=Paris/L=Paris/O=Ecole 42/OU=mbenicho/CN=mbenicho"

COPY conf/nginx.conf etc/nginx/conf.d/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
