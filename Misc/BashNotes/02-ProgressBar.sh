#!/bin/bash
START=0
END=333
COLUMNS=$(bc -l <<< "$(tput cols) - 10")
BLANK=""
for block in `seq 1 $((COLUMNS + 10))`; do
    BLANK="${BLANK} "
done
for i in `seq $START $END`; do
    STRING="[ "
    sleep 0.001s
    PERCENT=$(bc -l <<< "($i / $END) * 100" | cut -d. -f1 | xargs printf %03d )
    BLOCKS=$(bc -l <<< "$COLUMNS * ($PERCENT / 100)" | cut -d. -f1)
    for block in `seq 1 $BLOCKS`; do
        STRING="${STRING}#"
    done
    for block in `seq 1 $(( COLUMNS - BLOCKS ))`; do
        STRING="${STRING} "
    done
    echo -ne "\b$BLANK\r" >&2 
    echo -e "$PERCENT%"
    echo -ne "\b$STRING ]$PERCENT% ]\r" >&2
done
echo ""
