#!/usr/bin/env bash
a2enmod rewrite ssl
service apache2 restart
ifconfig
# sh /vagrant/scripts/source.sh

