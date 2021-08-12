#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
cd /home/ubuntu/
git clone https://gitlab.com/artarik/sbx-bg
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y && sudo apt install yarn -y
cd /home/ubuntu/sbx-bg/
sudo apt install nodejs -y
sudo apt install npm -y
yarn install
# We can get the IP address of instance
myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`
export PORT=80
sed -i 's|Main page|'$myip'|g' src/App.js
yarn start &
