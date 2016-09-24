#!/bin/bash

# Gets a random english wikipedia article and cuts it up as a haiku for tweeting

HAIKULOC='../../../605204/Haiku.py'
SOURCE='https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&redirects=1&generator=random'
OUTPUTS='/home/chip/Scripts/Twitter/AutoHaikuTweet/outputs'
AHAIKU=1

while [ $AHAIKU -eq 1 ]; do
    lynx --dump -width 1024 $SOURCE > .tempsite
    cat .tempsite | sed -e 's/.*"extract":"//' | sed -e 's/<[^<>]*>//g' | sed -e 's/([^()]*)//g' > .tempwhile
    TITLE=$(cat .tempsite | sed -e 's/.*title\"\:\"//g' | sed -e 's/\".*/\n/g' )
    cat .tempwhile | ascii2uni -a U -q | uni2ascii -q -B | sed -e 's/\\n/\n/g' | sed -e 's/\\//g' > .tempin
    $HAIKULOC -i .tempin -o .tempout > $OUTPUTS/tweet.txt
    HAIKU=$(cat $OUTPUTS/tweet.txt)
    NOTHAIKU=$(cat $OUTPUTS/notenoughwords.txt)
    if [ "$HAIKU" != "$NOTHAIKU" ]; then
        AHAIKU=0
    fi
done;
echo $TITLE 
cat $OUTPUTS/lasttweet.txt | ascii2uni -q | sed -e 's/[[:punct:]]//g'  > .temphere
cat .temphere > $OUTPUTS/lasttweet.txt
cat .temphere > "$OUTPUTS/$TITLE.txt"
rm .tempin .tempout .tempsite .temphere .tempwhile
#t update "$(cat $OUTPUTS/lasttweet.txt)" # Currently disabled for testing
echo "DONE!"
