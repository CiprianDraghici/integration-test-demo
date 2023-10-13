#!/bin/sh

# Exit with nonzero exit code if anything fails
set -e

# Install prerequisites
echo "Installing yarn..."
npm install --global yarn
echo "Installing yalc..."
npm install -global yalc


# Prepare mx-sdk-dapp for publishing
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


# Consume mx-sdk-dapp in mx-template-dapp-nextjs
git clone https://github.com/multiversx/mx-template-dapp-nextjs.git

echo "cd mx-template-dapp-nextjs..."
cd mx-template-dapp-nextjs
echo "git checkout main..."
# TODO checkout main
git checkout integration

echo "Linking mx-sdk-dapp..."
yalc link @multiversx/sdk-dapp

echo "Installing dependencies mx-template-dapp-nextjs..."
yarn install

echo "Building mx-template-dapp-nextjs..."
yarn build-devnet


echo "Script executed successfully!"
