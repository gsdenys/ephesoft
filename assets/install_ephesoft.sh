#!/usr/bin/env sh
set -e

# install Ephesoft
echo "Install Ephesoft in silentinstall mode..."
cd /tmp
unzip ephesoft.zip -d installer
cd installer

sed -i "/operating_system=/ s/=.*/=ubuntu"/ install-helper

chmod 755 *
./install -silentinstall
cd ..

echo "Remove the installer files... "
# get rid of installer - makes image smaller
rm -rf ephesoft.zip installer
