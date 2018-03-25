#!/bin/bash

#########################################################
# Update the OS
#########################################################
apt-get -q update
printf "\n System updated \n"

#########################################################
# Install PHP
#########################################################
printf "\n ################### PHP 7.2 ################## \n"
apt-get install -yq python-software-properties
add-apt-repository -yq ppa:ondrej/php
apt-get -q update
apt-get install -yq php7.2
apt-get install -yq php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-fpm

#update php.ini
cp /etc/php/7.2/fpm/php.ini /etc/php/7.2/fpm/php.ini.backup
sed -i -e 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.2/fpm/php.ini

systemctl restart php7.2-fpm.service
systemctl enable php7.2-fpm.service

#########################################################
# Install Nginx
#########################################################
printf "\n ################### Nginx ################## \n"
apt-get remove -yq apache2*
printf "\n Apache removed \n"

apt-get install -yq nginx
cp /etc/nginx/sites-available/default default.backup
wget -q https://raw.githubusercontent.com/mohokh67/Ubuntu-Essential-PHP/master/files/nginx.conf -O /etc/nginx/sites-available/default
systemctl restart nginx
systemctl enable nginx
nginx -t

#########################################################
# Install Composer
#########################################################
printf "\n ################### Composer ################## \n"
wget -q https://getcomposer.org/composer.phar
mv composer.phar composer
chmod +x composer
mv composer /usr/local/bin/

#########################################################
# Install Node.js
#########################################################
printf "\n ################### Node & NPM ################## \n"
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
apt-get install -yq nodejs
apt-get install -yq build-essential

#########################################################
# Clean up
#########################################################
printf "\n ################### Clean up ################## \n"
apt-get -y autoremove
apt-get -y autoclean

#########################################################
# Installed App version:
#########################################################
printf "\n ---------------------------------- Nginx version \n"
nginx -v
printf "\n ---------------------------------- PHP version \n"
php --version
printf "\n ---------------------------------- Composer version \n"
composer --version
printf "\n ---------------------------------- Node version \n"
node --version
printf "\n ---------------------------------- NPM version \n"
npm --version

printf "\n ---------------------------------------------------------- \n"
printf "\n |                        Done                             |\n"
printf "\n ---------------------------------------------------------- \n"

printf "\n Welcome to the Ubuntu Xenial 26.04 LTS with Nginx, PHP7.2, Composer and Node.js"
printf "\n View the development webiste in your browser 'http://localhost:8080'"
printf "\n Run 'vagrant ssh' to login to the machine"
