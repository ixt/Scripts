#!/bin/bash
repo=~orange/Projects/Scripts/Twitter/UpdateingAwakeAliveRepoAndTweet
file=../../README.md
cd $repo
# git log --oneline > .commits
# git pull origin master
# git log --oneline > .commitsnew
commits=$(echo $(diff .commits .commitsnew | tail --lines=+2 | cut -d" " -f2 | sed -e "a\ " | tr -d '\n'))
for commit in $commits; do
    git checkout $commit
    while read entry; do
        tweet=$(echo $entry | sed -e 's/# //g')
        echo $tweet
    done < $file
done
git checkout master
# cd back
