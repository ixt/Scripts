#!/bin/bash
# Desktop is useless lets use it for "temporary" files

PHOTOBACKUPLOCATION=/home/orange/Desktop/photos/dreher/

scp $CHIP:photos/dreher/* ~/Desktop/photos/dreher/
BEGINNING=$(ls $PHOTOBACKUPLOCATION -1 | tail -1 | sed -e 's/.jpg//g')
END=$(ls $PHOTOBACKUPLOCATION -1 | head -1 | sed -e 's/.jpg//g')
TARNAME=$(echo $BEGINNING"-"$END".tar.gz" | sed -e 's/+0000//g')
tar -czvf $PHOTOBACKUPLOCATION$TARNAME $PHOTOBACKUPLOCATION*.jpg
rm $PHOTOBACKUPLOCATION*.jpg
ssh $CHIP 'rm photos/dreher/*.jpg'
