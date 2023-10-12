#!/bin/sh

sudo apt-get update
sudo apt-get install git-all

# Install Node.js
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Yarn
npm install --global yarn
# Install Yalc
npm install -global yalc

#git config --global url.https://github.com/.insteadOf git://github.com/
#git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf git@github.com/

git clone https://github.com/multiversx/mx-sdk-dapp.git
git clone https://github.com/multiversx/mx-template-dapp.git

cd mx-sdk-dapp
git checkout development
yarn install
yarn build
cd dist
yalc publish

cd ../mx-template-dapp
git checkout main
yarn install
yalc link @multiversx/sdk-dapp
yarn build:devnet

# Exit immediately if a command exits with a non-zero status.
set -e