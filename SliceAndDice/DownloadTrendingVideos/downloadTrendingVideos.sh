#!/bin/bash 
TEMP=$(mktemp)
# https://www.youtube.com/feed/trending?gl=
wget -qO- https://youtube.com/feed/trending | sed -e "s/[\"><]/\n/g" | grep watch?v= | cut -d"&" -f 1 | sed -e "s/^\//https:\/\/www.youtube.com\//g" | sort | uniq > $TEMP

while read entry; do
    printf "Downloading: $entry \n"
    bash ./download.sh $entry &
done < $TEMP
wait
printf "Done."
