#!/bin/bash
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_4.x | sudo -E bash -
sudo yum -y install nodejs
sudo yum -y install git
sudo yum -y install mc
sudo git clone https://github.com/garedrag/chess.git
sed -i "s/localhost/$(echo "$(hostname -I)" | sed 's/ $//')/g" /chess/lib/client/assets/nodejs-chess-0.1.0.js
sed -i "s/localhost/$(echo "$(hostname -I)" | sed 's/ $//')/g" /chess/config.js
cd /chess
sudo npm install
npm build
sudo npm run build
sudo chmod 777 /chess
sudo chown -R $(whoami) *
npm start & sudo npm run client
