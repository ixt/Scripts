#!/bin/bash
# needs fswebcam, a webcam, t and their dependencies
NAME=$(date +%c)
FILENAME=$(date -Iseconds | sed s/\ /_/g | sed s/\:/-/g)

fswebcam -d /dev/video0 --set "Exposure, Auto=Aperture Priority Mode" --set "Focus, Auto=False" --set "Focus (Absolute)=30" -S 100 -r 4000x4000 --jpeg 100 /home/orange/output.png
convert /home/orange/output.png -crop 1000x1020+460-60 /home/orange/photos/reallife/$FILENAME.jpg
t update "$NAME #theinternetisreallife" -f "/home/orange/photos/reallife/$FILENAME.jpg"

