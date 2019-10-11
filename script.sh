#!/bin/bash
sudo apt-get install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get -y install nodejs
sudo apt-get -y install git
sudo apt-get -y install mc
sudo git clone https://github.com/garedrag/chess.git /chess
sed -i "s/localhost/$(echo "$(hostname -I)" | sed 's/ $//')/g" /chess/lib/client/assets/nodejs-chess-0.1.0.js
sed -i "s/localhost/$(echo "$(hostname -I)" | sed 's/ $//')/g" /chess/config.js
cd /chess
sudo npm install
npm build
sudo npm run build
sudo chmod 777 /chess
sudo chown -R $(whoami) *
# npm start & sudo npm run client
