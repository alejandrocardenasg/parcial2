#!/bin/bash
sudo yum install vim -y
sudo yum install ftp -y
sudo yum install wget -y
sudo yum install telnet telnet-server -y
sudo yum install httpd -y
sudo yum install bind-utils bind-libs bind-* -y
sudo yum install openssl -y
sudo yum install mod_ssl -y

sudo cp -r -a /vagrant/httpd /etc/
sudo chmod -R 755 /etc/httpd

sudo cp -r -a /vagrant/named.conf /etc/
sudo chmod -R 640 /etc/named.conf

sudo cp -r -a /vagrant/named /var/
sudo chmod -R 755 /var/named/gxt.com.fwd
sudo chmod -R 755 /var/named/gxt.com.rev
sudo chmod -R 755 /var/named/gxt2.com.rev
 
sudo echo '#conf file' > /etc/selinux/config
sudo echo 'SELINUX=disabled' >> /etc/selinux/config
sudo echo 'SELINUXTYPE=targeted' >> /etc/selinux/config

sudo echo 'GATEWAY=192.168.100.4' >> /etc/sysconfig/network

sudo service network restart

sudo touch /var/www/html/index.html

echo 'Hola Mundo' >  /var/www/html/index.html

route del -net 0.0.0.0 gw 10.0.2.2 netmask 0.0.0.0 dev eth0