#!/bin/bash

#This script is provided by Chiunownow https://github.com/Chiunownow
#Thank you very much for providing this script
#This script is 

#use e.g with that script: MySensor.sh 
#!/bin/bash
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#$DIR/LYWSD03MMC.py -d <device> -b 1000 -r --debounce --skipidentical 50 --name MySensor --callback sendToMQTT

rssi=$7
if [ $rssi -gt -50 ]
then 
	rssi=10
elif [ $rssi -le -98 ]
then 
	rssi=0
else 
  	rssi=$((rssi + 97))
  	rssi=$(( (rssi / 5) + 1))
fi

MESSAGE="{\"device\":\"$2\", \"temperature\":$3, \"humidity\":$4, \"batteryvoltage\":$5, \"batterylevel\":$6, \"rssi\":$rssi }"
echo "DEBUG: $(date) msg:$MESSAGE"
mosquitto_pub -h localhost -t "MiTemperature2" -m "$MESSAGE"
