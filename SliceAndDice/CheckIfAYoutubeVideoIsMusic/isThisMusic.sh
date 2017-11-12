#!/bin/bash
# youtube-dl https://www.youtube.com/playlist?list=PLirAqAtl_h2r5g8xGajEwdXd3x1sZh8hC --get-id --ignore-errors >> .ids
# sed -e "s@\(.*\)@http://www.youtube.com/watch?v=\1@g" .ids > .urls

isThis(){
    wget $1 -qO- | grep "Category" -A 6 | cut -d">" -f3 | grep "Music"
    [ $? == "1" ] && echo "not music" && $(echo "$1" >> .list) && return 0
    echo "music" && return 1
}

while read url; do
    isThis ${url}
done < .urls
