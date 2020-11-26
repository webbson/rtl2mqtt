#!/bin/bash

export LANG=C
PATH="/usr/bin:/usr/sbin:/bin:/sbin"

if [ -z "$MQTT_HOST" ]
then
      echo "\$MQTT_HOST is empty"
      exit
fi

if [ -z "$MQTT_USER$MQTT_PASSWORD" ]
then
  AUTH=""
else
  AUTH=",user=$MQTT_USER,pass=$MQTT_PASSWORD"
fi

/usr/bin/rtl_433 -C si -F "mqtt://$MQTT_HOST$AUTH,retain=1,devices=rtl_433[/id]"
