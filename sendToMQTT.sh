#!/bin/bash

#This script is provided by Chiunownow https://github.com/Chiunownow
#Thank you very much for providing this script
#This script is 

#use e.g with that script: MySensor.sh 
#!/bin/bash
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#$DIR/LYWSD03MMC.py -d <device> -b 1000 -r --debounce --skipidentical 50 --name MySensor --callback sendToMQTT

#mosquitto_pub -h localhost -t "MiTemperature2/$2/temp" -u mqtt.username -P mqtt.passwd -i "mibridge" -m "$3"
#mosquitto_pub -h localhost -t "MiTemperature2/$2/humidity" -u mqtt.username -P mqtt.passwd -i "mibridge" -m "$4"
#mosquitto_pub -h localhost -t "MiTemperature2/$2/batteryvoltage" -u mqtt.username -P mqtt.passwd -i "mibridge" -m "$5"
#mosquitto_pub -h localhost -t "MiTemperature2/$2/batterylevel" -u mqtt.username -P mqtt.passwd -i "mibridge" -m "$6"

rssi=$7
if [ $rssi -gt -50 ]
then 
	rssi=10
#	echo 'rssi: lower limit 10' 
elif [ $rssi -le -98 ]
then 
	rssi=0
#	echo 'rssi: upper limit 0'
else 
  	rssi=$((rssi + 97))
  	rssi=$(( (rssi / 5) + 1))
#	echo "rssi: calc $rssi"
fi

#mosquitto_pub -h localhost -t "MiTemperature2/$2/rssi" -u mqtt.username -P mqtt.passwd -i "mibridge" -m "$rssi"

#MESSAGE="{ \"idx\":18, \"nvalue\":0, \"svalue\":\"$3;$4;0\", \"Battery\":$6, \"RSSI\":$rssi }"
#echo "DEBUG: $(date) msg:$MESSAGE"
#mosquitto_pub -h localhost -t "domoticz/in" -m "$MESSAGE"

MESSAGE="{ \"temp\":$3, \"humidity\":$4, \"batteryvoltage\":$5, \"batterylevel\":$6, \"rssi\":$rssi }"
echo "DEBUG: $(date) msg:$MESSAGE"
mosquitto_pub -h localhost -t "MiTemperature2/$2" -m "$MESSAGE"
