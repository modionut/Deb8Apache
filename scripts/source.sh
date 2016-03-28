#!/usr/bin/env bash

sourceLockFile="/vagrant/locks/source.lock"

mkdir -p /vagrant/locks

if [ ! -e "$sourceLockFile" ]; then

    touch $sourceLockFile

    #create
    #tar -zcvf archive-name.tar.gz directory-name

    #extract
    echo "extract source.tar.gz ..."
    tar -zxf /vagrant/source/source.tar.gz -C /var/www/html

    DB_NAME='sorce_db_name'
    SQL='/vagrant/source/source.sql'
    connection=' -h 127.0.0.1 -u root -proot'
    afterInportBaseQuery=""
    echo "Import $LOCFILE"
    echo "DROP DATABASE IF EXISTS $DB_NAME; CREATE DATABASE IF NOT EXISTS $DB_NAME;USE $DB_NAME; SET foreign_key_checks = 0; SOURCE $SQL; SET foreign_key_checks = 1; $afterInportBaseQuery" | mysql $connection
    rm $SQL

    rm /var/www/html/index.html

else
    echo "$sourceLockFile exist !"
fi


