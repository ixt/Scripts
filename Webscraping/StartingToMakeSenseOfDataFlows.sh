#!/bin/bash

stack=( "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" )
while read line; do
    ip=$(echo $line | egrep -o "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | tail -1 | sed "s/://g")
    num=0
    for address in ${stack[*]}; do
        if [[ "$address" == "0" ]]; then
            ./IPinCountryOut.sh "$ip"
            stack[$num]="$ip"
            break
        elif [[ "$address" == "$ip" ]]; then
            break
        elif [[ "$address" != "$ip" && "$num" == "9" ]]; then
            stack[0]=${stack[1]}
            stack[1]=${stack[2]}
            stack[2]=${stack[3]}
            stack[3]=${stack[4]}
            stack[4]=${stack[5]}
            stack[5]=${stack[6]}
            stack[6]=${stack[7]}
            stack[7]=${stack[8]}
            stack[8]=${stack[9]}
            stack[9]=$ip
            ./IPinCountryOut.sh "$ip"
            break
        fi
        : $(( num += 1 ))
    done
    num=0
    # echo "${stack[0]},${stack[1]},${stack[2]},${stack[3]},${stack[4]}"
done < <(sudo tcpdump -l -n)

