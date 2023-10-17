#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $DIR

#uncomment following line to use in python virtual environment
#source bin/activate
source /srv/dev-disk-by-uuid-2bb769cc-1798-4c89-b342-b738df3f6d87/appdata/python3-venv/bin/activate

echo "$(date): start.sh: MI Bluetooth sensor startup..."
arguments="--passive --battery --rssi --watchdogtimer 60 --callback sendToMQTT.sh"
python -u ./LYWSD03MMC.py $arguments >> ~/logs/mi_result.log &
echo "$(date): start.sh: MI Bluetooth sensor startup is started in background"
