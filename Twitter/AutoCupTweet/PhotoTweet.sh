#!/bin/bash
# needs fswebcam, a webcam, t and their dependencies
NAME=$(date +%c)
FILENAME=$(date -Iseconds | sed s/\ /_/g | sed s/\:/-/g)

fswebcam -r 1920x1080 --font sans:50 --top-banner --banner-colour "#FF000000" --line-colour "#FFFF4500" --no-shadow -S 300 --jpeg 100 "/home/pi/photos/dreher/$FILENAME.jpg" 
t update "$NAME #drehertweet" -f "/home/pi/photos/dreher/$FILENAME.jpg"
