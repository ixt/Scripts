#!/bin/bash
# Script to takes random frames from a video 
# CC-0 Orange 2017

# TODO:
#   [x] - Actually working
#   [ ] - Package check
#   [ ] - Offer to install packages


check_pkgs(){
    # Do a check for ffmpeg and mediainfo
    return
}

input=$1
workingdir=$(pwd) 

frameCount=$(mediainfo --full-scan "$input" | grep "Frame count" | head -1 | cut -d':' -f 2)

randomFrame=$(echo "$RANDOM % $frameCount" | bc )
randomFrame1=$(echo "$RANDOM % $frameCount" | bc )
randomFrame2=$(echo "$RANDOM % $frameCount" | bc )
randomFrame3=$(echo "$RANDOM % $frameCount" | bc )

# Adapted in part from https://stackoverflow.com/a/36189866
ffmpeg -i "$input" -vf select="'eq(n\,$randomFrame)+eq(n\,$randomFrame1)+eq(n\,$randomFrame2)+eq(n\,$randomFrame3)'",scale=320:-1 \
                -vsync vfr -q:v 2 -f image2pipe -vcodec ppm - \
                  | montage -tile 2x2 -geometry "1x1+0+0<" -quality 100 -frame 1 - "$input.$randomFrame.png"
