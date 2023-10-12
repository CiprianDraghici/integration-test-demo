#!/bin/sh

echo "Installing git..."
sudo apt-get update
sudo apt-get install jq
sudo apt-get install git-all

#git config --global url."https://${GITHUB_TOKEN}@github.com/".insteadOf git@github.com:

echo "Installing yarn..."
npm install --global yarn

echo "Cloning mx-template-dapp..."
git clone https://github.com/multiversx/mx-template-dapp.git
set -e

echo "cd mx-template-dapp..."
cd mx-template-dapp
echo "git checkout main..."
# TODO checkout main
git checkout integration

# Define the package name and the new version number
PACKAGE_NAME="@multiversx/sdk-dapp"
#NEW_VERSION="git://github.com/multiversx/mx-sdk-dapp.git#development"
NEW_VERSION="multiversx/mx-sdk-dapp.git#development"

# Use jq to update the sdk-dapp package version in package.json
jq --arg new_version "$NEW_VERSION" '.dependencies |= . + {("'"$PACKAGE_NAME"'"): $new_version}' package.json > temp.json && mv temp.json package.json
echo "$PACKAGE_NAME version has been updated to $NEW_VERSION"

# Display the new version of the package.json file
cat package.json

echo "Installing dependencies mx-template-dapp..."
yarn install
set -e
echo "Building mx-template-dapp..."
yarn build:devnet
set -e

echo "Script executed successfully!"
