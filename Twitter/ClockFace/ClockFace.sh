#!/usr/bin/env bash
FILEDIR=$(dirname $0)
convert -background black -fill orangered -size 500x500 -pointsize 160 -gravity center label:`date -u +%H:%M` $FILEDIR/output.png
t set profile_image $FILEDIR/output.png 
