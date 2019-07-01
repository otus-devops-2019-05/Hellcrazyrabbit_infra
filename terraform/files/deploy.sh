#!/bin/bash
set -e
APP_DIR=${1:-$HOME}
if [[ -d $APP_DIR/reddit ]] && echo "Dir reddit exists"
then sudo rm -Rf $APP_DIR/reddit && echo "Dir removed"
fi
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
