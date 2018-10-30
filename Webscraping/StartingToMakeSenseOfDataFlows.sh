#!/bin/bash
cat test.txt | egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | sed "/^100\./d" | sort | uniq -c 
