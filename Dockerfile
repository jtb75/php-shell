FROM php:7.2.1-apache
COPY index.php /var/www/html
RUN rm /etc/rc*.d/S01apache2
EXPOSE 80
ENTRYPOINT ["/usr/sbin/apachectl", "-D" , "FOREGROUND"]
