#!/bin/bash
# NoFacesForNames Backup

BACKUPPLACE=/home/orange/Desktop/photos/NoFacesForNames/
NOFACEDIR=/home/orange/Projects/NoFacesForNames
BEGINNING=$(ls $NOFACEDIR/images/ -1 | tail -1 | sed -e 's/\///g')
END=$(ls $NOFACEDIR/images/ -1 | head -1 | sed -e 's/\///g')
TARNAME=$(echo $BEGINNING"-"$END".tar.gz")

#tar -czvf $NOFACEDIR/$TARNAME $NOFACEDIR/images/*
rm $NOFACEDIR/images/* -r
#mv $NOFACEDIR/$TARNAME $BACKUPPLACE
