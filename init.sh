#!/bin/bash

# CHECKOUT SOURCES
defaultRepo="https://github.com/kin3303/efdemo"

BRANCH=${1:-master} 
REMOTE_REPO=${2:-$defaultRepo}

mkdir $BRANCH
cd $BRANCH

apt-get install -y git
git init
git remote add -t $BRANCH -f origin $REMOTE_REPO
git checkout $BRANCH 

chmod 777 data/*

# MAKE ALIAS
echo -e "alias efinstall='bash ./setup/install.sh'" >> ~/.bashrc
echo -e "alias efstart='bash ./setup/start.sh'" >> ~/.bashrc
echo -e "alias efconfig='bash ./setup/config.sh'" >> ~/.bashrc
echo -e "alias efsetdemo='bash ./setup/demo_config.sh'" >> ~/.bashrc
echo -e "alias efstop='bash ./setup/stop.sh'" >> ~/.bashrc
echo -e "alias efscale='bash ./setup/scale.sh'" >> ~/.bashrc
echo -e "alias efbackup='bash ./setup/backup.sh'" >> ~/.bashrc
echo -e "alias efrestore='bash ./setup/restore.sh'" >> ~/.bashrc
echo -e "alias efupload='bash ./upload.sh'" >> ~/.bashrc
echo -e "alias eftuning='bash ./setup/tuning.sh'" >> ~/.bashrc

