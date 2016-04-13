#! /bin/env bash
# needs fswebcam, a webcam, t and their dependencies
NAME=$(date +%c | sed s/\ /_/g | sed s/\:/-/g)

fswebcam -r 640x480 --banner-colour "#FF000000" --line-colour "#FFFF4500" --no-shadow --jpeg 100 "/home/pi/photos/$NAME.jpg"
t update "$NAME #drehertweet" -f "/home/pi/photos/$NAME.jpg"
