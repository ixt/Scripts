#!/bin/bash
LAT=$2
LNG=$3
TEMP=$(mktemp)
CRONTEMP=$(mktemp)
SCRIPT=$1
crontab -l > $CRONTEMP
while read entry; do
    sed -e "${entry}d" -i $CRONTEMP
done < <(grep -n "$SCRIPT" $CRONTEMP 2>/dev/null | cut -d: -f1 | tac ) 
wget -qO $TEMP "https://api.sunrise-sunset.org/json?lat=$LAT&lng=$LNG" && jq ".results" $TEMP | cut -d: -f2- | sed -e "1d;11,12d" -e "s/,//g" | xargs -I@ date --date="@" +"%M %H * * * ${SCRIPT}" >> $CRONTEMP
crontab $CRONTEMP
