#!/bin/bash

# Gets a random english wikipedia article and cuts it up as a haiku for tweeting

HOMEDIR=''
HAIKULOC="/home/orange/Projects/605204/Haiku.py"
SOURCE='https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&redirects=1&generator=random'
OUTPUTS="/home/orange/Projects/Scripts/Twitter/AutoHaikuTweet/outputs"
AHAIKU=1

while [ $AHAIKU -eq 1 ]; do
    lynx --dump -width 1024 $SOURCE > .tempsite
    cat .tempsite | sed -e 's/.*"extract":"//' | sed -e 's/<[^<>]*>//g' | sed -e 's/([^()]*)//g' > .tempwhile
    TITLE=$(cat .tempsite | sed -e 's/.*title\"\:\"//g' | sed 's/:punct://g' | sed -e 's/\".*/\:\n/g' )
    URL=$(echo https://en.wikipedia.org/wiki/$(cat .tempsite | sed -e 's/.*title\"\:\"//g' | sed 's/:punct://g' | sed -e 's/ /\_/g' | sed -e 's/\".*/\n/g' ) )
    echo $TITLE > .title
    cat .tempwhile | ascii2uni -a U -q | uni2ascii -q -B | sed -e 's/\\n/\n/g' | sed -e 's/\\//g' | sed -e 's/[0-9]//g' > .tempin
    echo $URL > .url
    $HAIKULOC -i .tempin -o .tempout > $OUTPUTS/lasttweet.txt
    HAIKU=$(cat $OUTPUTS/lasttweet.txt)
    NOTHAIKU=$(cat $OUTPUTS/notenoughwords.txt)
    if grep -q "User\|Talk" .title; then
        echo "wah"
    else
        if [ "$HAIKU" != "$NOTHAIKU" ]; then
            AHAIKU=0
        fi
    fi
done;
echo $TITLE > .title
cat .title $OUTPUTS/lasttweet.txt .url > .temphere
cat .temphere 
cat .temphere > "$OUTPUTS/$TITLE.txt"
t update "$(cat .temphere)"
rm .tempin .tempout .tempsite .temphere .tempwhile .title .url
echo "DONE!"
