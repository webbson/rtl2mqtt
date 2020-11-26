#
# Docker file to create an image that contains enough software to listen to events on the 433,92 Mhz band,
# filter these and publish them to a MQTT broker.
#
# The script resides in a volume and should be modified to meet your needs.

# Special attention is required to allow the container to access the USB device that is plugged into the host.
# The container needs priviliged access to /dev/bus/usb on the host.
# 
# docker run --name rtl_433 -d -e MQTT_HOST=<mqtt-broker.example.com>   --privileged -v /dev/bus/usb:/dev/bus/usb  <image>

FROM ubuntu:20.10

LABEL Description="This image is used to start a script that will monitor for events on 433,92 Mhz" Vendor="MarCoach" Version="1.0"

RUN apt-get update && apt-get install -y rtl-433

ENV MQTT_HOST=""
ENV MQTT_USER=""
ENV MQTT_PASSWORD=""

ENTRYPOINT ["/scripts/rtl2mqtt.sh"]


COPY rtl2mqtt.sh /scripts/rtl2mqtt.sh
RUN chmod +x /scripts/rtl2mqtt.sh
VOLUME ["/scripts"]