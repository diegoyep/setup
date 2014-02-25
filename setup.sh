#!/bin/sh

apt-get update
apt-get dist-upgrade
apt-get -y install apache2
apt-get -y install php5 libapache2-mod-php5
/etc/init.d/apache2 restart

sudo adduser ubuntu www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rw /var/www

echo mysql-server-5.1 mysql-server/root_password password finalf  | debconf-set-selections
echo mysql-server-5.1 mysql-server/root_password_again password finalf | debconf-set-selections
apt-get install -y mysql-server

sudo apt-get install phpmyadmin
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf

sudo /etc/init.d/apache2 reload

sudo apt-get install unzip
wget http://ellislab.com/asset/ci_download_files/reactor/CodeIgniter_2.1.3.zip
unzip CodeIgniter_2.1.3.zip


exit 0

