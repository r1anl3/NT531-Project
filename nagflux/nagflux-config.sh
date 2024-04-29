#!/bin/bash

echo $'\t EXECUTING NAGFLUX'
cd /opt/nagflux
sudo sh -c "printf '[main]\n' > config.gcfg"
sudo sh -c "printf '\tNagiosSpoolfileFolder = \"/usr/local/nagios/var/spool/nagfluxperfdata\"\n' >> config.gcfg"
sudo sh -c "printf '\tNagiosSpoolfileWorker = 1\n' >> config.gcfg"
sudo sh -c "printf '\tInfluxWorker = 2\n' >> config.gcfg"
sudo sh -c "printf '\tMaxInfluxWorker = 5\n' >> config.gcfg"
sudo sh -c "printf '\tDumpFile = \"nagflux.dump\"\n' >> config.gcfg"
sudo sh -c "printf '\tNagfluxSpoolfileFolder = \"/usr/local/nagios/var/nagflux\"\n' >> config.gcfg"
sudo sh -c "printf '\tFieldSeparator = \"&\"\n' >> config.gcfg"
sudo sh -c "printf '\tBufferSize = 10000\n' >> config.gcfg"
sudo sh -c "printf '\tFileBufferSize = 65536\n' >> config.gcfg"
sudo sh -c "printf '\tDefaultTarget = \"all\"\n' >> config.gcfg"
sudo sh -c "printf '\n' >> config.gcfg"
sudo sh -c "printf '[Log]\n' >> config.gcfg"
sudo sh -c "printf '\tLogFile = \"\"\n' >> config.gcfg"
sudo sh -c "printf '\tMinSeverity = \"INFO\"\n' >> config.gcfg"
sudo sh -c "printf '\n' >> config.gcfg"
sudo sh -c "printf '[InfluxDBGlobal]\n' >> config.gcfg"
sudo sh -c "printf '\tCreateDatabaseIfNotExists = true\n' >> config.gcfg"
sudo sh -c "printf '\tNastyString = \"\"\n' >> config.gcfg"
sudo sh -c "printf '\tNastyStringToReplace = \"\"\n' >> config.gcfg"
sudo sh -c "printf '\tHostcheckAlias = \"hostcheck\"\n' >> config.gcfg"
sudo sh -c "printf '\n' >> config.gcfg"
sudo sh -c "printf '[InfluxDB \"nagflux\"]\n' >> config.gcfg"
sudo sh -c "printf '\tEnabled = true\n' >> config.gcfg"
sudo sh -c "printf '\tVersion = 1.0\n' >> config.gcfg"
sudo sh -c "printf '\tAddress = \"http://127.0.0.1:8086\"\n' >> config.gcfg"
sudo sh -c "printf '\tArguments = \"precision=ms&u=root&p=root&db=nagflux\"\n' >> config.gcfg"
sudo sh -c "printf '\tStopPullingDataIfDown = true\n' >> config.gcfg"
sudo sh -c "printf '\n' >> config.gcfg"
sudo sh -c "printf '[InfluxDB \"fast\"]\n' >> config.gcfg"
sudo sh -c "printf '\tEnabled = false\n' >> config.gcfg"
sudo sh -c "printf '\tVersion = 1.0\n' >> config.gcfg"
sudo sh -c "printf '\tAddress = \"http://127.0.0.1:8086\"\n' >> config.gcfg"
sudo sh -c "printf '\tArguments = \"precision=ms&u=root&p=root&db=fast\"\n' >> config.gcfg"
sudo sh -c "printf '\tStopPullingDataIfDown = false\n' >> config.gcfg"

echo $'\t STARTING NAGFLUX'
sudo service nagflux.service start

echo $'\t VALIDATING NAGFLUX TO INFLUXDB CONFIGURATION'
curl -G "http://localhost:8086/query?pretty=true" --data-urlencode "q=show databases"