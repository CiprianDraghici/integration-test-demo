#!/bin/sh

set -e # Exit with nonzero exit code if anything fails

echo "Installing yarn..."
npm install --global yarn
echo "Installing yalc..."
npm install -global yalc


git clone https://github.com/multiversx/mx-sdk-dapp.git
echo "cd mx-sdk-dapp..."
cd mx-sdk-dapp
git checkout development
echo "Installing dependencies for mx-sdk-dapp..."
yarn install
echo "Building mx-sdk-dapp..."
yarn build
echo "Publishing mx-sdk-dapp..."
cd dist
yalc publish
cd ../..


git clone https://github.com/multiversx/mx-template-dapp.git
echo "cd mx-template-dapp..."
cd mx-template-dapp
echo "git checkout main..."
# TODO checkout main
git checkout integration
echo "Installing dependencies mx-template-dapp..."
yarn install
echo "Linking mx-sdk-dapp..."
yalc link @multiversx/sdk-dapp
echo "Building mx-template-dapp..."
yarn build:devnet

echo "Script executed successfully!"
