#!/bin/bash

# install deps
yum install mysql-server mysql php-mysql php-pear php-common php-gd php-devel php php-mbstring php-cli php-snmp php-pear-Net-SMTP php-mysql httpd -y

# mysql db
mysql -u root -p -e 'create database cacti;'
mysql -u root -p -e 'GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY "zYn95ph43zYtq";'
mysql -u root -p -e 'FLUSH privileges;'

yum install net-snmp-utils php-snmp net-snmp-libs -y

cd /etc/snmp/
mv snmpd.conf old-snmpd-conf
wget https://s3-eu-west-1.amazonaws.com/ruan-bekker/repo/configs/snmpd.conf

/etc/init.d/snmpd start
chkconfig snmpd on

yum install cacti -y

cactisql=`rpm -ql cacti | grep cacti.sql`

mysql -u cacti -pzYn95ph43zYtq cacti < $cactisql

echo "# vi /etc/cacti/db.php"
sed -i 's/$database_username = "cactiuser";/$database_username = "cacti";/g' /etc/cacti/db.php
sed -i 's/$database_password = "cactiuser";/$database_password = "zYn95ph43zYtq";/g' /etc/cacti/db.php

echo "# vi /etc/httpd/conf.d/cacti.conf"
sed -i s'/Deny from all/Allow from all/'g /etc/httpd/conf.d/cacti.conf

echo "*/5 * * * *     cacti   /usr/bin/php /usr/share/cacti/poller.php > /dev/null 2>&1" >> /etc/cron.d/cacti
/etc/init.d/crond restart
