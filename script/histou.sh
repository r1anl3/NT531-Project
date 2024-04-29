#bin/bash
# https://github.com/Griesbacher/histou

echo $'\t DOWNLOADING HISTOU'
cd /tmp
wget -O histou.tar.gz https://github.com/Griesbacher/histou/archive/v0.4.3.tar.gz
sudo mkdir -p /var/www/html/histou
cd /var/www/html/histou

echo $'\t EXTRACTING HISTOU'
sudo tar xzf /tmp/histou.tar.gz --strip-components 1

echo $'\t INSTALLING HISTOU'
sudo cp histou.ini.example histou.ini
sudo cp histou.js /usr/share/grafana/public/dashboards/

echo $'\t DONE!'