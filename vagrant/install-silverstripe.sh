#!/usr/bin/env bash
cd /var/www
sudo rm -rf *.*
sudo rm -rf *\.*
composer create-project silverstripe/installer .
