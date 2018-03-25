#!/bin/bash

#########################################################
# Update the OS
#########################################################
printf "Updating system ..."
apt-get -qq update



#########################################################
# Install PHP
#########################################################
printf "Installing PHP 7.2 ..."
apt-get install -y -qq python-software-properties
add-apt-repository -y ppa:ondrej/php
apt-get -qq update
apt-get install -y -qq php7.2
apt-get install -y -qq php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-fpm

#update php.ini
cp /etc/php/7.2/fpm/php.ini /etc/php/7.2/fpm/php.ini.backup
sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini

systemctl -q restart php7.2-fpm.service
systemctl -q enable php7.2-fpm.service

#########################################################
# Remove Apache
#########################################################
printf "Removing Apache ..."
service apache2 stop
apt-get remove -y apache2*

#########################################################
# Install Nginx
#########################################################
printf "Installing Nginx ..."
apt-get install -y -qq nginx
cp /etc/nginx/sites-available/default default.backup
wget -q https://raw.githubusercontent.com/mohokh67/Ubuntu-Essential-PHP/master/files/nginx.conf -O /etc/nginx/sites-available/default
systemctl -q restart nginx
systemctl -q enable nginx
#nginx -t

#########################################################
# Install Composer
#########################################################
printf "Installing Composer ..."
wget -q https://getcomposer.org/composer.phar
mv composer.phar composer
chmod +x composer
mv composer /usr/local/bin/

#########################################################
# Install Node.js
#########################################################
printf "Installing Node & NPM ..."
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
apt-get install -y -qq nodejs
apt-get install -y -qq build-essential

#########################################################
# Clean up
#########################################################
printf "Clean up ..."
apt-get -y autoremove
apt-get -y autoclean

printf "\n Welcome to the Ubuntu Xenial 26.04 LTS with Nginx, PHP7.2, Composer and Node.js"
printf "\n View the development webiste in your browser 'http://localhost:8080'"
printf "\n Run 'vagrant ssh' to login to the machine"
