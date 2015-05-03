#!/usr/bin/env bash
aptitude update
aptitude install -y php5 php-pear apache2 php5-suhosin php5-curl expect php-apc php5-sybase php5-intl php5-gd curl git php5-tidy

# Set default mysql password
debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'
aptitude -y install mysql-server php5-mysql
# cp /etc/mysql/my.cnf ~/my.cnf.backup

# # Secure installation
MYSQL_ROOT_PASSWORD=vagrant
SECURE_MYSQL=$(expect -c "
 
set timeout 10
spawn mysql_secure_installation
 
expect \"Enter current password for root (enter for none):\"
send \"$MYSQL_ROOT_PASSWORD\r\"
 
expect \"Change the root password?\"
send \"n\r\"
 
expect \"Remove anonymous users?\"
send \"y\r\"
 
expect \"Disallow root login remotely?\"
send \"y\r\"
 
expect \"Remove test database and access to it?\"
send \"y\r\"
 
expect \"Reload privilege tables now?\"
send \"y\r\"
 
expect eof
")
 
 echo "$SECURE_MYSQL"

# # Performance optimization
# cp /vagrant/vagrant/apc.ini /etc/php5/apache2/conf.d/apc.ini
sed -i 's/memory_limit = .*/memory_limit = 384M/' /etc/php5/apache2/php.ini
sed -i 's/\;date\.timezone =.*/date\.timezone = Europe\/London/' /etc/php5/apache2/php.ini

# #Dev see errors
sed -i 's/display_errors = .*/display_errors = On/' /etc/php5/apache2/php.ini

mkdir -p /vagrant/logs

# # Link web root
rm -rf /var/www
ln -fs /vagrant/public_html /var/www

# # Setup MSSQL unicode
# cp /vagrant/vagrant/freetds.conf /etc/freetds/freetds.conf

# # Set hostname based site
a2dissite *

rm -f /etc/apache2/sites-available/*.conf
cp /vagrant/vagrant/*.conf /etc/apache2/sites-available/

a2ensite *
 
# Enable apache modules
 a2enmod rewrite


cd /tmp
# echo 'suhosin.executor.include.whitelist = phar' >> /etc/php5/conf.d/suhosin.ini
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Reload Apache
service apache2 restart

echo 'IP ADDRESS:'
hostname -I

echo 'To install silverstripe run from the VM: sh /vagrant/vagrant/install-silverstripe.sh'