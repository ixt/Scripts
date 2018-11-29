#!/bin/bash

coproc TCPDUMP { \
    sudo tcpdump -s 0 -v \
}

while read line; do
    egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
    echo "$ip"
done < sudo tcpdump -s 0 -v

