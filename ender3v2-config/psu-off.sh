#!/bin/sh

. ~/.env

curl https://api.pushcut.io/$PUSHCUT_TOKEN/execute?homekit=Printer%20Off
sleep 5
sudo /home/pi/uhubctl/uhubctl -l 1-1.2 -a 0
