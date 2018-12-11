#!/bin/bash
TEMP=$(mktemp)
OBJECTTEMP=$(mktemp)
if [[ -f "IPDB.json" ]]; then
    cp IPDB.json $TEMP
    sed -i "$ d" $TEMP
    echo "," >> $TEMP
fi
[[ ! -f "IPDB.json" ]] && echo "{" > $TEMP
#while read IP; do
IP=$1
    if grep -q "\<${IP}\>" $TEMP; then
        # echo "Already there" >&2
        STRING=".[\"${IP}\"]"
        sed -i "$ d" $TEMP
        echo "}" >> $TEMP
        jq "$STRING" $TEMP 2>/dev/null > $OBJECTTEMP
        sed -i "$ d" $TEMP
        echo "," >> $TEMP
    else
        echo "\"${IP}\": " >> $TEMP
        curl -s "https://api.ip2country.info/ip?${IP}" | tee -a $TEMP > $OBJECTTEMP
        echo "," >> $TEMP
    fi
    NAME=$(jq -r ".countryName" $OBJECTTEMP 2>/dev/null)
    EMOJI=$(jq -r ".countryEmoji" $OBJECTTEMP 2>/dev/null)
    echo "$IP: $EMOJI $NAME"
# done < <<<"${1}"
sed -i "$ d" $TEMP
echo "}" >> $TEMP

cp $TEMP IPDB.json 

