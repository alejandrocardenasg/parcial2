#!/bin/bash
sudo yum install vim -y
sudo yum install vsftpd -y
sudo yum install sendmail sendmail-cf -y
sudo yum install dovecot -y
sudo yum install telnet telnet-server -y
sudo yum install wget -y
sudo yum install openssl -y
sudo yum install bind-utils bind-libs bind-* -y

sudo cp -r -a /vagrant/vsftpd /etc/
sudo chmod -R 755 /etc/vsftpd

sudo cp -r -a /vagrant/mail /etc/
sudo chmod -R 755 /etc/mail

sudo cp -r -a /vagrant/dovecot /etc/
sudo chmod -R 755 /etc/dovecot

sudo echo '#conf file' > /etc/selinux/config
sudo echo 'SELINUX=disabled' >> /etc/selinux/config
sudo echo 'SELINUXTYPE=targeted' >> /etc/selinux/config

sudo echo 'GATEWAY=192.168.100.4' >> /etc/sysconfig/network

sudo service network restart

route del -net 0.0.0.0 gw 10.0.2.2 netmask 0.0.0.0 dev eth0
