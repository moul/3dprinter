#!/bin/sh

. ~/.env

sudo /home/pi/uhubctl/uhubctl -l 1-1.2 -a 1
curl https://api.pushcut.io/$PUSHCUT_TOKEN/execute?homekit=Printer%20%20ON
sleep 2
