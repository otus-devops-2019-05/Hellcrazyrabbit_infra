#!/bin/bash
cd "$HOME" || exit
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
echo " [Unit]
Description=Puma HTTP server
After =network.target
[Service]
User=appuser
Type=simple
WorkingDirectory=/home/appuser/reddit/
ExecStart=/usr/local/bin/puma
Restart=always
RestartSec=10
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/puma.service
systemctl enable puma
