#!/bin/bash

##
# Install the Autoconf ephesoft dependency. This is required to ephesoft works good in the Centos 6
##

cd /tmp/

wget ftp://ftp.pbone.net/mirror/ftp5.gwdg.de/pub/opensuse/repositories/home:/monkeyiq:/centos6updates/CentOS_CentOS-6/noarch/autoconf-2.69-12.2.noarch.rpm

rpm -Uvh /tmp/autoconf-2.69-12.2.noarch.rpm