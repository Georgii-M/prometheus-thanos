#!/bin/bash

# Make node_exporter user
sudo adduser --no-create-home --disabled-login --shell /bin/false --gecos "Node Exporter User" node_exporter

# Download node_exporter and copy utilities to where they should be in the filesystem
VERSION=$(curl https://raw.githubusercontent.com/prometheus/node_exporter/master/VERSION)
wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz
tar xvzf node_exporter-${VERSION}.linux-amd64.tar.gz

sudo cp node_exporter-${VERSION}.linux-amd64/node_exporter /usr/local/bin/
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

sudo tee -a /etc/systemd/system/node_exporter.service << END
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
END

sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter

# Installation cleanup
rm node_exporter-${VERSION}.linux-amd64.tar.gz
rm -rf node_exporter-${VERSION}.linux-amd64

