FROM nextcloud:24

RUN apt-get update && apt-get install -y aria2

RUN mkdir /var/log/aria2c /var/local/aria2c

RUN touch /var/log/aria2c/aria2c.log

RUN touch /var/local/aria2c/aria2c.sess

RUN chown www-data.www-data -R /var/log/aria2c /var/local/aria2c

RUN chmod 770 -R /var/log/aria2c /var/local/aria2c

CMD ["apache2-foreground"]
