#!/bin/bash

# Gets a random english wikipedia article and cuts it up as a haiku for tweeting

HAIKULOC='../../../605204/Haiku.py'
SOURCE='https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&redirects=1&generator=random'
AHAIKU=1

while [ $AHAIKU -eq 1 ]; do
    lynx --dump -width 1024 $SOURCE > .tempsite
    cat .tempsite | sed -e 's/.*"extract":"//' | sed -e 's/<[^<>]*>//g' | sed -e 's/([^()]*)//g' > .tempwhile
    cat .tempwhile | ascii2uni -a U -q | uni2ascii -q -B | sed -e 's/\\n/\n/g' | sed -e 's/\\//g' > .tempin
    $HAIKULOC -i .tempin -o .tempout > outputs/tweet.txt
    HAIKU=$(cat outputs/tweet.txt)
    NOTHAIKU=$(cat outputs/notenoughwords.txt)
    if [ "$HAIKU" != "$NOTHAIKU" ]; then
        AHAIKU=0
    fi
done;
echo $NAVIGATION $TITLE $entry
cat outputs/tweet.txt | ascii2uni -q | sed -e 's/[[:punct:]]//g'  > .temphere
cat .temphere 
cat .temphere > outputs/tweet.txt
rm .tempin .tempout .tempsite .temphere .tempwhile
t update "$(cat outputs/tweet.txt)"
echo "DONE!"
