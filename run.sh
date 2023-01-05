#!/bin/bash

if [ $# -ne 8 ];
then
  echo "$1 <MIIO_IP> <MIIO_TOKEN> <MIIO_FETCH_INTERVAL> <MQTT_IP> <MQTT_PORT> <MQTT_USER> <MQTT_PASSWORD> <MQTT_TOPIC>"
  exit 1
fi

re='^[0-9]+$'
while true;
do
  ret="{ "
  while read line
  do
    key=$(echo $line | cut -d ":" -f 1 | sed -r 's/ //g' | sed -r 's/\.//g' | sed -r 's/₂/2/g')
    value=$(echo $line | cut -d ":" -f 2 | cut -d " " -f 2)
    if ! [[ $value =~ $re ]];
    then
      ret=$ret"\"$key\":\"$value\","
    else
      ret=$ret"\"$key\":$value,"
    fi
  done < <(miiocli airqualitymonitorcgdn1 --ip "$1" --token "$2" status)
  json="${ret::-1}""}"
  echo $json
  mosquitto_pub -h "$4" -p $5 -u "$6" -P "$7" -t "$8" -m "$json"
  sleep $3
done


