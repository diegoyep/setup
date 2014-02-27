#!/bin/sh

apt-get -y update
apt-get -y dist-upgrade
apt-get -y install apache2
apt-get -y install php5 libapache2-mod-php5
/etc/init.d/apache2 restart

sudo adduser ubuntu www-data
sudo chown -R www-data:www-data /var/www
sudo chmod -R g+rw /var/www

echo mysql-server-5.1 mysql-server/root_password password finalf  | debconf-set-selections
echo mysql-server-5.1 mysql-server/root_password_again password finalf | debconf-set-selections
apt-get install -y mysql-server

sudo apt-get -y install phpmyadmin
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf.d/phpmyadmin.conf

sudo /etc/init.d/apache2 reload

sudo apt-get install -y unzip
wget http://ellislab.com/asset/ci_download_files/reactor/CodeIgniter_2.1.3.zip
unzip CodeIgniter_2.1.3.zip

mkdir root
mv CodeIgniter_2.1.3 codeig
mv codeig/index.php root

sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get -qq update
sudo apt-get install -y emacs24-nox emacs24-el emacs24-common-non-dfsg

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

wget https://raw.githubusercontent.com/ejmr/php-mode/master/php-mode.el
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/startup-class/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

mv php-mode.el ~/.emacs.d

echo "change root file on /etc/apache2/site-availables/default file"
echo "edit index.php on codeigniter and change error reporting settings and system folder setup"
echo "and add php-mode to emacs"

exit 0

