#!/bin/bash
set -e

# vars
ALF_HOME=/alfresco
ALF_BUILD=201602-build-00005
ALF_BIN=alfresco-community-installer-201602-linux-x64.bin

# get alfresco installer
mkdir -p $ALF_HOME
cd /tmp
curl -O http://dl.alfresco.com/release/community/$ALF_BUILD/$ALF_BIN

chmod +x $ALF_BIN

# install alfresco
./$ALF_BIN --mode unattended --prefix $ALF_HOME --alfresco_admin_password admin

# get rid of installer - makes image smaller
rm $ALF_BIN