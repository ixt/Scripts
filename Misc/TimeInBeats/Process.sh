#!/bin/bash

secondsSinceMidnight=$(( $( TZ=":Etc/GMT-1" date "+(10#%H * 60 + 10#%M) * 60 + 10#%S") )) 

beats=$(echo "scale=5;($secondsSinceMidnight / 86400)*1000" | bc | cut -d. -f1)

echo @$beats
