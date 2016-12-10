#!/usr/bin/env sh
set -e

#EPHESOFT_VERSION=4.0.2.0

#EPHESOFT_ZIP=Ephesoft_Community_Release_$EPHESOFT_VERSION.zip
#EPHESOFT_FOLDER_BASE=Ephesoft_Community_$EPHESOFT_VERSION/
#EPHESOFT_URL=http://www.ephesoft.com/Ephesoft_Product/$EPHESOFT_FOLDER_BASE/$EPHESOFT_ZIP


# get Ephesoft zip installer
#echo "Start do download Ephesoft version " $EPHESOFT_VERSION
#mkdir -p $EPHESOFT_HOME
#cd /tmp
#curl -O $EPHESOFT_URL

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
