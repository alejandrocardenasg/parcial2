#!/bin/bash
sudo yum install vim -y
sudo yum install wget -y
sudo yum install ftp -y
sudo yum install telnet telnet-server -y
sudo yum install bind-utils bind-libs bind-* -y

sudo service NetworkManager stop
sudo chkconfig NetworkManager off

sudo service firewalld start
sudo chkconfig firewalld on

sudo service firewalld restart

sudo firewall-cmd --zone=dmz --add-interface=eth1 --permanent
sudo firewall-cmd --zone=internal --add-interface=eth2 --permanent

sudo firewall-cmd --zone=dmz --add-interface=eth2
sudo firewall-cmd --zone=internal --add-interface=eth1

sudo firewall-cmd --direct --permanent --add-rule ipv4 nat POSTROUTING 0 -o eth2 -j MASQUERADE
sudo firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i eth1 -o eth2 -j ACCEPT
sudo firewall-cmd --direct --permanent --add-rule ipv4 filter FORWARD 0 -i eth2 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo firewall-cmd --zone=internal --add-masquerade --permanent
sudo firewall-cmd --zone=dmz --add-masquerade --permanent

sudo firewall-cmd --zone=dmz --add-service={http,https,dns,ftp,smtps,pop3s,imaps} --permanent
sudo firewall-cmd --zone=internal --add-service={http,https,dns,ftp,smtps,pop3s,imaps} --permanent

sudo firewall-cmd --zone=dmz --add-forward-port=80:proto=tcp:toport=80:toaddr=192.168.100.3 --permanent
sudo firewall-cmd --zone=dmz --add-forward-port=443:proto=tcp:toport=443:toaddr=192.168.100.3 --permanent
sudo firewall-cmd --zone=dmz --add-forward-port=21:proto=tcp:toport=21:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=dmz --add-forward-port=465:proto=tcp:toport=465:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=dmz --add-forward-port=993:proto=tcp:toport=993:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=dmz --add-forward-port=995:proto=tcp:toport=995:toaddr=192.168.100.2 --permanent

sudo firewall-cmd --zone=internal --add-forward-port=80:proto=tcp:toport=80:toaddr=192.168.100.3 --permanent
sudo firewall-cmd --zone=internal --add-forward-port=443:proto=tcp:toport=443:toaddr=192.168.100.3 --permanent
sudo firewall-cmd --zone=internal --add-forward-port=21:proto=tcp:toport=21:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=internal --add-forward-port=465:proto=tcp:toport=465:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=internal --add-forward-port=993:proto=tcp:toport=993:toaddr=192.168.100.2 --permanent
sudo firewall-cmd --zone=internal --add-forward-port=995:proto=tcp:toport=995:toaddr=192.168.100.2 --permanent

sudo echo '#conf file' > /etc/selinux/config
sudo echo 'SELINUX=disabled' >> /etc/selinux/config
sudo echo 'SELINUXTYPE=targeted' >> /etc/selinux/config

sudo echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf



