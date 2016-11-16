#!/bin/bash

# Gets a random english wikipedia article and cuts it up as a haiku for tweeting

HOMEDIR="/home/pi"
HAIKULOC=$(echo "$HOMEDIR""/605204/Haiku.py")
OUTPUTS=$(echo "$HOMEDIR""/Scripts/Twitter/AutoHaikuTweet/outputs")
SOURCE='https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&redirects=1&generator=random'
AHAIKU=1

while [ $AHAIKU -eq 1 ]; do
    lynx --dump -width 1024 $SOURCE > .tempsite
    cat .tempsite | sed -e 's/.*"extract":"//g;s/<[^<>]*>//g;s/([^()]*)//g' > .tempwhile
    TITLE=$(cat .tempsite | sed -e 's/.*title\"\:\"//g;s/:punct://g;s/\".*/\:\n/g' )
    echo $TITLE | ascii2uni -a U -q | uni2ascii -q -B | sed -e 's/\\n/\n/g;s/\\//g;s/[0-9]//g'> .title
    URL=$(echo https://en.wikipedia.org/wiki/$(cat .title | sed -e 's/ /_/g;s/\://g') )
    echo $URL > .url
    cat .tempwhile | ascii2uni -a U -q | uni2ascii -q -B | sed -e 's/\\n/\n/g;s/[0-9|\\]//g' > .tempin
    $HAIKULOC -i .tempin -o .tempout > $OUTPUTS/lasttweet.txt
    HAIKU=$(cat $OUTPUTS/lasttweet.txt)
    NOTHAIKU=$(cat $OUTPUTS/notenoughwords.txt)
    if grep -q "User\|Talk\|File\|Title" .title; then
        echo "wah"
    else
        if [ "$HAIKU" != "$NOTHAIKU" ]; then
            AHAIKU=0
        fi
    fi
done;
cat .title $OUTPUTS/lasttweet.txt .url > .temphere
cat .temphere
echo "#6t" >> .temphere
cat .temphere > "$OUTPUTS/$TITLE.txt"
t update "$(cat .temphere)"
rm .tempin .tempout .tempsite .temphere .tempwhile .title .url
echo "DONE!"
