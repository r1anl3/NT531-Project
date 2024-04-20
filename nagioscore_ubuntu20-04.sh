#!/bin/bash
echo "/t STEP 1: Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y autoconf gcc libc6 make wget unzip apache2 php libapache2-mod-php7.4 libgd-dev
sudo apt-get install openssl libssl-dev

echo "/t STEP 2:  Downloading Nagios core..."
cd /tmp
wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.14.tar.gz
tar xzf nagioscore.tar.gz

echo "/t STEP 3: Compiling Nagios core..."
cd /tmp/nagioscore-nagios-4.4.14/
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled
sudo make all

echo "/t STEP 4: Creating User and Group..."
sudo make install-groups-users
sudo usermod -a -G nagios www-data

echo "/t STEP 5: Installing binaries..."
sudo make install

echo "/t STEP 6: Installing Service/Daemon..."
sudo make install-daemoninit

echo "/t STEP 7: Installing Command Mode..."
sudo make install-commandmode

echo "/t STEP 8: Installing configuration files..."
sudo make install-config

echo "/t STEP 9: Installing Apache config files..."
sudo make install-webconf
sudo a2enmod rewrite
sudo a2enmod cgi

echo "/t STEP 10: Configuring firewall..."
sudo ufw allow Apache
sudo ufw reload

echo "/t STEP 11: Creating nagiosadmin User Account..."
sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

echo "/t STEP 12: Starting Apache Web Server..."
sudo systemctl restart apache2.service

echo "/t STEP 13: Starting Service/Daemon..."
sudo systemctl start nagios.service

echo "/t STEP 14: Downloading Nagios plugins..."
cd /tmp
wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.6.tar.gz
tar zxf nagios-plugins.tar.gz

echo "/t STEP 15: Compling and Installing Nagios plugins..."
cd /tmp/nagios-plugins-release-2.4.6/
sudo ./tools/setup
sudo ./configure
sudo make
sudo make install
echo "DONE"