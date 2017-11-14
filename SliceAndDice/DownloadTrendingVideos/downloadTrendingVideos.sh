#!/bin/bash 
TEMP=$(mktemp)
MAX=10
CURRENTDATE=$(TZ=UTC date +%Y-%m-%d-%H)

# Grab each territory that speaks a bunch of english
TERRITORIES=( NG KE CA GH SG IE JM MY GB US AU NZ )
# https://www.youtube.com/feed/trending?gl=
for i in ${TERRITORIES[@]}; do
    wget -qO- "https://youtube.com/feed/trending?gl=$i" | sed -e "s/[\"><]/\n/g" | grep watch?v= | cut -d"&" -f 1- | sort | sed -e "s/^\//https:\/\/www.youtube.com\//g" | uniq >> $TEMP
    printf "Downloaded $i ids\n"
done

# Remove broken IDs that im not sure how they are caused but this will just remove them
sort $TEMP | uniq | sed -e "s/.*=//g" | egrep "^[A-Za-z0-9_-]{10,100}" > ${CURRENTDATE}.list

#COUNT=0
#while read entry; do
#    if [ "$COUNT" -lt "$MAX" ]; then 
#        printf "Downloading: $entry \n"
#        bash ./download.sh $entry &
#        : $( COUNT += 1 )
#    else
#        wait
#        : $( COUNT == 1 )
#        printf "Downloading: $entry \n"
#        bash ./download.sh $entry &
#        : $( COUNT += 1 )
#    fi
#done < .currentTrendIds
#wait
#printf "Done."
