#!/bin/bash
sudo yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
sudo yum -y install nodejs
sudo yum -y install git
sudo yum -y install mc
sudo git clone https://github.com/garedrag/chess.git
cd /chess
sudo npm install
sudo npm build
sudo npm run build
npm start & sudo npm run client
