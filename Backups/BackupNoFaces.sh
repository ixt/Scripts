#!/bin/bash
# NoFacesForNames Backup

BACKUPPLACE=/home/orange/Desktop/photos/NoFacesForNames/
NOFACEDIR=/home/orange/Projects/NoFacesForNames
BEGINNING=$(ls $NOFACEDIR/files/ -1 | tail -1 | sed -e 's/\///g')
END=$(ls $NOFACEDIR/files/ -1 | head -1 | sed -e 's/\///g')
TARNAME=$(echo $BEGINNING"-"$END".tar.gz")

tar -czvf $NOFACEDIR/$TARNAME $NOFACEDIR/files/*
rm $NOFACEDIR/files/* -r
mv $NOFACEDIR/$TARNAME $BACKUPPLACE
