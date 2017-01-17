#!/bin/bash
# Desktop is useless lets use it for "temporary" files

PHOTOBACKUPLOCATION=~/Desktop/photos/dreher/jpgs/
PLACETOTAKEFROM=$RPIE

mkdir $PHOTOBACKUPLOCATION -p
scp $PLACETOTAKEFROM:photos/dreher/* $PHOTOBACKUPLOCATION 

BEGINNING=$(ls $PHOTOBACKUPLOCATION -1 | tail -1 | sed -e 's/.jpg//g')
END=$(ls $PHOTOBACKUPLOCATION -1 | head -1 | sed -e 's/.jpg//g')
if [ -n $END ]; then
    TARNAME=$(echo $BEGINNING"-"$END".tar.gz" | sed -e 's/+0000//g')
    tar -czvf $PHOTOBACKUPLOCATION../$TARNAME $PHOTOBACKUPLOCATION*.jpg
    rm $PHOTOBACKUPLOCATION*.jpg
fi

# same with the lines below, comment out gpg-agent, uncomment ssh
ssh $PLACETOTAKEFROM 'rm photos/dreher/*.jpg'
