#bin/bash
#https://support.nagios.com/kb/article/nagios-core-performance-graphs-using-influxdb-nagflux-grafana-histou-802.html#Ubuntu

echo $'\t CREATING GOPATH'
echo "export GOPATH=$HOME/gorepo" >> ~/.bashrc
source ~/.bashrc
mkdir $GOPATH

echo $'\t COMPILING NAGFLUX'
go get -v -u github.com/griesbacher/nagflux
go build github.com/griesbacher/nagflux 
sudo mkdir -p /opt/nagflux
sudo cp $GOPATH/bin/nagflux /opt/nagflux/
sudo mkdir -p /usr/local/nagios/var/spool/nagfluxperfdata
sudo chown nagios:nagios /usr/local/nagios/var/spool/nagfluxperfdata 

echo $'\t CREATING SERVICES'
sudo cp $GOPATH/src/github.com/griesbacher/nagflux/nagflux.service /lib/systemd/system/
sudo chmod +x /lib/systemd/system/nagflux.service
sudo systemctl daemon-reload
sudo systemctl enable nagflux.service

echo $'\t DONE!'