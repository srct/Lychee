FROM ubuntu:14.04
MAINTAINER Student-Run Computing and Technology - GMU

# Install base packages
RUN apt-get update
RUN apt-get -y install git curl nano wget build-essential

# Install apache and PHP
RUN apt-get -y install apache2 mysql-server libapache2-mod-php5
RUN apt-get -y install php5-mysql php5-gd php5-curl
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Link /var/www to /app directory
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
WORKDIR /app

# Clone lychee
RUN git clone https://github.com/srct/Lychee.git .

# Set file permissions
RUN chown www-data:www-data /app -R
RUN chmod -R 777 uploads/ data/

EXPOSE 80
CMD script/server
