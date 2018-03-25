#!/bin/bash

#########################################################
# Update the OS
#########################################################
apt-get update

#########################################################
# Install PHP
#########################################################
apt-get install -y python-software-properties
add-apt-repository -y ppa:ondrej/php
apt-get update
apt-get install -y php7.2
apt-get install -y php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-fpm

#update php.ini
cp /etc/php/7.2/fpm/php.ini /etc/php/7.2/fpm/php.ini.backup
sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini

systemctl restart php7.2-fpm.service
systemctl enable php7.2-fpm.service

#########################################################
# Install Nginx
#########################################################
apt-get remove -y apache2*

apt-get install -y nginx
cp /etc/nginx/sites-available/default default.backup
wget -q https://raw.githubusercontent.com/mohokh67/Ubuntu-Essential-PHP/master/files/nginx.conf -O /etc/nginx/sites-available/default
systemctl restart nginx
systemctl enable nginx
nginx -t

#########################################################
# Install Composer
#########################################################
wget https://getcomposer.org/composer.phar
mv composer.phar composer
chmod +x composer
mv composer /usr/local/bin/

#########################################################
# Install Node.js
#########################################################
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
apt-get install -y nodejs
apt-get install -y build-essential

#########################################################
# Clean up
#########################################################
apt-get autoremove
apt-get autoclean

#########################################################
# Installed App version:
#########################################################
nginx -v
php --version
composer --version
node --version
npm --version

printf "\n Welcome to the Ubuntu Xenial 26.04 LTS with Nginx, PHP7.2, Composer and Node.js"
printf "\n View the development webiste in your browser 'http://localhost:8080'"
printf "\n Run 'vagrant ssh' to login to the machine"
