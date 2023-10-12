#!/bin/sh

set -e # Exit with nonzero exit code if anything fails

echo "Installing yarn..."
npm install --global yarn

git clone https://github.com/multiversx/mx-template-dapp.git

echo "cd mx-template-dapp..."
cd mx-template-dapp
echo "git checkout main..."
# TODO checkout main
git checkout integration

# Define the package name and the new version number
PACKAGE_NAME="@multiversx/sdk-dapp"
NEW_VERSION="multiversx/mx-sdk-dapp.git#development"

# Use jq to update the sdk-dapp package version in package.json
jq --arg new_version "$NEW_VERSION" '.dependencies |= . + {("'"$PACKAGE_NAME"'"): $new_version}' package.json > temp.json && mv temp.json package.json
echo "$PACKAGE_NAME version has been updated to $NEW_VERSION in package.json"

# Display the new version of the package.json file
cat package.json

echo "Installing dependencies for mx-template-dapp..."
yarn install
echo "Building mx-template-dapp..."
yarn build:devnet

echo "Script executed successfully!"
