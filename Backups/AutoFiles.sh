#!/bin/bash
# Desktop is useless lets use it for "temporary" files

PHOTOBACKUPLOCATION=/home/orange/Desktop/photos/dreher/jpgs/

# this is the command I use as I use a GPG key as my SSH sometimes (you may want to comment it out)
gpg-agent --enable-ssh-support --daemon scp $CHIP:photos/dreher/* $PHOTOBACKUPLOCATION
# Uncomment this to use real scp
# scp $chip:photos/dreher/* $photobackuplocation

BEGINNING=$(ls $PHOTOBACKUPLOCATION -1 | tail -1 | sed -e 's/.jpg//g')
END=$(ls $PHOTOBACKUPLOCATION -1 | head -1 | sed -e 's/.jpg//g')
if [ -n $END ]; then
    TARNAME=$(echo $BEGINNING"-"$END".tar.gz" | sed -e 's/+0000//g')
    tar -czvf $PHOTOBACKUPLOCATION../$TARNAME $PHOTOBACKUPLOCATION*.jpg
    rm $PHOTOBACKUPLOCATION*.jpg
fi

# same with the lines below, comment out gpg-agent, uncomment ssh
gpg-agent --enable-ssh-support --daemon ssh $CHIP 'rm photos/dreher/*.jpg'
# ssh $CHIP 'rm photos/dreher/*.jpg'
