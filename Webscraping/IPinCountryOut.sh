#!/bin/bash
TEMP=$(mktemp)
OBJECTTEMP=$(mktemp)
if [[ -f "IPDB.json" ]]; then
    cp IPDB.json $TEMP
    sed -i "$ d" $TEMP
    echo "," >> $TEMP
fi
[[ ! -f "IPDB.json" ]] && echo "{" > $TEMP
while read IP; do
    if grep -q "\<${IP}\>" $TEMP; then
        echo "Already there" >&2
        STRING=".[\"${IP}\"]"
        sed -i "$ d" $TEMP
        echo "}" >> $TEMP
        jq "$STRING" $TEMP > $OBJECTTEMP
        sed -i "$ d" $TEMP
        echo "," >> $TEMP
    else
        echo "\"${IP}\": " >> $TEMP
        curl "https://api.ip2country.info/ip?${IP}" | tee -a $TEMP > $OBJECTTEMP
        echo "," >> $TEMP
    fi
    NAME=$(jq -r ".countryName" $OBJECTTEMP)
    EMOJI=$(jq -r ".countryEmoji" $OBJECTTEMP)
    echo "$IP: $EMOJI $NAME"
done < "${1:-/dev/stdin}"
sed -i "$ d" $TEMP
echo "}" >> $TEMP

cp $TEMP IPDB.json 

