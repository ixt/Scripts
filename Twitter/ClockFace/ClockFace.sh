#!/usr/bin/env bash
FILEDIR=$(dirname $0)
convert -background black -fill orangered -size 500x500 -font /usr/share/fonts/truetype/dseg/DSEG7Classic-BoldItalic.ttf -pointsize 128 -gravity center label:`/home/orange/Projects/Scripts/Misc/TimeInBeats/Process.sh` $FILEDIR/output.png
t set profile_image $FILEDIR/output.png 
