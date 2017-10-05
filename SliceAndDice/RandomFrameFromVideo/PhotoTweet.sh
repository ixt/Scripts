#!/bin/bash

CURRENTDIR=$(dirname $0)
FILE=$(ls -1 -d --ignore="*.sh,*.txt,*.part" /media/Korea/Stimme/* /media/Korea/DPRKToday/* | shuf | head -1)
YOUTUBE_ID=$(echo "$FILE" | rev | cut -d"." -f2 | cut -c1-11 | rev)
TITLE=$(echo "$FILE" | rev | cut -d"." -f2 | cut -c13- | rev | sed -e "s@/media/Korea/.*/@@g")

cd $CURRENTDIR

./Process.sh "$FILE" 2> ~/cronoutput

/usr/local/bin/t update "$TITLE #rjv https://www.youtube.com/watch?v=${YOUTUBE_ID}" -f "~/Scripts/SliceAndDice/RandomFrameFromVideo/output.png" 
