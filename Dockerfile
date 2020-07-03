FROM php:apache
COPY index.php /var/www/html
RUN apt-get update && apt-get upgrade -y
RUN update-rc.d apache2 disable
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
