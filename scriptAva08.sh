#!/bin/bash
usuario=$LOGNAME
data=`date +"%y%m%d"`
sudo mkdir -p /home/back/$usuario.$data
sudo cp -Riu $HOME /home/back/$usuario.$data