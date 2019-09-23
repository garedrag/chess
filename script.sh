#!/bin/bash
yum install -y gcc-c++ make
curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
yum -y install nodejs
yum -y install git
yum -y install mc
sudo git clone https://github.com/garedrag/chess.git
cd /chess
npm install
npm build
npm run build
npm start & sudo npm run client
