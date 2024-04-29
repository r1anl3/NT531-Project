#!/bin/sh
#https://medium.com/yavar/install-and-setup-influxdb-on-ubuntu-20-04-22-04-3d6e090ec70c

echo $'\t GETTING PAKAGES'
wget -q https://repos.influxdata.com/influxdata-archive_compat.key
echo '393e8779c89ac8d958f81f942f9ad7fb82a25e133faddaf92e15b16e6ac9ce4c influxdata-archive_compat.key' | sha256sum -c && cat influxdata-archive_compat.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg > /dev/null
echo 'deb [signed-by=/etc/apt/trusted.gpg.d/influxdata-archive_compat.gpg] https://repos.influxdata.com/debian stable main' | sudo tee /etc/apt/sources.list.d/influxdata.list

echo $'\t INSTALLING INFLUXDB2'
sudo apt-get update
sudo apt-get install influxdb2 -y
influx version

echo $'\t STARTING INFLUXDB'
sudo systemctl start influxdb

echo $'\t ENABLING INFLUXDB'
sudo systemctl enable influxdb

echo $'\t CHECKING INFLUXDB STATUS'

SERVICE=influxdb;
if ps ax | grep -v grep | grep $SERVICE > /dev/null
then
    echo "$SERVICE service running, everything is fine"
else
    echo "$SERVICE is not running"
    sudo service influxdb start
fi

echo $'\t OPENING PORT 8086'
sudo ufw allow 8086/tcp

echo $'\t DONE! VISIT http://localhost:8086/ TO ACCESS INFLUXDB2'