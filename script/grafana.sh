#bin/bash
#https://grafana.com/docs/grafana/latest/setup-grafana/start-restart-grafana/

echo $'\t INSTALLING PRE-REQUISITES'
sudo apt-get install -y apt-transport-https software-properties-common wget

echo $'\t IMPORTING GRAFANA GPG KEY'
sudo mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null

echo $'\t ADDING GRAFANA STABLE REPOSITORY'
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

echo $'\t UPDATING PACKAGE LISTS'
# Updates the list of available packages
sudo apt-get update

echo $'\t INSTALLING GRAFANA OSS'
# Installs the latest OSS release:
sudo apt-get install grafana -y

echo $'\t OPENING PORT 3000'
sudo ufw allow 3000/tcp
sudo ufw reload

echo $'\t STARTING GRAFANA'
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server

echo $'\t DONE! VISIT http://localhost:3000/ TO ACCESS GRAFANA'