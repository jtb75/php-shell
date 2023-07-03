FROM php:8-apache
COPY index.php /var/www/html
RUN rm /etc/rc*.d/S01apache2
COPY ulimits /tmp
RUN cat /tmp/ulimits >> /etc/security/limits.conf
EXPOSE 80
LABEL org.opencontainers.image.authors="nospam.joe@gmail.com"
LABEL org.opencontainers.image.source="https://github.com/jtb75/php-shell"
LABEL org.opencontainers.image.vendor="jtb"
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D" , "FOREGROUND"]
