#!/bin/sh

echo "Installing git..."
sudo apt-get update
sudo apt-get install git-all

echo "Installing yarn..."
npm install --global yarn
echo "Installing yalc..."
npm install -global yalc

echo "Cloning mx-sdk-dapp..."
git clone https://github.com/multiversx/mx-sdk-dapp.git

echo "Cloning mx-template-dapp..."
git clone https://github.com/multiversx/mx-template-dapp.git

echo "cd mx-sdk-dapp..."
cd mx-sdk-dapp
echo "git checkout development..."
git checkout development
echo "Installing dependencies mx-sdk-dapp..."
yarn
echo "Building mx-sdk-dapp..."
yarn build
echo "Publishing mx-sdk-dapp..."
cd dist
yalc publish
ls -la

echo "cd mx-template-dapp..."
cd ..
cd ..
cd mx-template-dapp
echo "git checkout main..."
git checkout integration
echo "Installing dependencies mx-template-dapp..."
yarn
echo "Linking mx-sdk-dapp..."
yalc link @multiversx/sdk-dapp
echo "Building mx-template-dapp..."
yarn build:devnet

# Exit immediately if a command exits with a non-zero status.
set -e