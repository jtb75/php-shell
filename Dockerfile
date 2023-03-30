FROM php:7.2.1-apache
COPY index.php /var/www/html
RUN rm /etc/rc*.d/S01apache2
EXPOSE 80
LABEL org.opencontainers.image.authors="nospam.joe@gmail.com"
LABEL org.opencontainers.image.source="https://github.com/jtb75/php-shell"
LABEL org.opencontainers.image.vendor="jtb75"
CMD ["/usr/sbin/apachectl", "-D" , "FOREGROUND"]
