A docker image to convert MIIO protocol to MQTT. Tested on Qingping Air Quality Monitor Lite only.

Usage:
`sudo docker run --rm -it tocatro/miio_mqtt <MIIO_IP> <MIIO_TOKEN> <MIIO_FETCH_INTERVAL> <MQTT_IP> <MQTT_PORT> <MQTT_USER> <MQTT_PASSWORD> <MQTT_TOPIC>`