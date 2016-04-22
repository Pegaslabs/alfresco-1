#!/bin/bash
set -e

# vars
ALF_HOME=/alfresco
ALF_BIN=alfresco-community-installer-201602-linux-x64.bin

# get alfresco installer
mkdir -p $ALF_HOME
cd /tmp
# Not working at the moment
#curl -O http://dl.alfresco.com/release/community/5.0.d-build-00002/$ALF_BIN
# Downloading instead from sourceforge
curl -O http://heanet.dl.sourceforge.net/project/alfresco/Alfresco%20201602%20Community/$ALF_BIN

chmod +x $ALF_BIN

# install alfresco
./$ALF_BIN --mode unattended --prefix $ALF_HOME --alfresco_admin_password admin

# get rid of installer - makes image smaller
rm $ALF_BIN
