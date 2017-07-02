#!/usr/bin/env bash
FILEDIR=$(dirname $0)
convert -background black -fill orangered -size 500x500 -font /usr/share/fonts/truetype/dseg/DSEG7Classic-BoldItalic.ttf -pointsize 100 -gravity center label:`date -u +%H:%M` $FILEDIR/output.png
t set profile_image $FILEDIR/output.png 
