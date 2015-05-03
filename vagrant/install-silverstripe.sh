#!/usr/bin/env bash
cd /var/www
sudo rm -rf *.*
sudo rm -rf *\.*
composer create-project silverstripe/installer .
cp /vagrant/_ss_environment.default.php /vagrant/_ss_environment.php -n