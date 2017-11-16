#!/bin/bash
# Skip bytes really didnt work 
IN=$1
OUT=$(date +%s)
SKIP=${2:-0}
dd bs=4M if=$IN iflag=skip_bytes skip=$SKIP \
    | pv -ep -s 16G -b | bzgrep -o -f DateExpressions.list > $OUT
