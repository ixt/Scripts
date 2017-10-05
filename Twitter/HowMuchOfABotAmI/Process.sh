#!/bin/bash
# Use the Botometer API to tweet your bot score!
FIELDS=$(t whoami -c | cut -d, -f1,9 | tail -1)
IFS=,  read -a line <<< "$FIELDS"
TEMP=$(mktemp)
APIKEY=""

cat <<EOF > $TEMP
{
    "user": {
        "id": "${line[0]}",
        "screen_name": "${line[1]}"
    }
    "timeline": [
EOF
# Add in timeline tweets 
while read entry; do
    IFS=,  read -a tweet <<< "$entry"
    echo "        {" >> $TEMP
    echo "            \"id\": \"${tweet[0]}\"," >> $TEMP
    echo "            \"posted_at\": \"${tweet[1]}\"," >> $TEMP
    echo "            \"screen_name\": \"${tweet[2]}\"," >> $TEMP
    echo "            \"text\": \"${tweet[3]}\"" >> $TEMP
    echo "        }," >> $TEMP
done < <(t timeline ${line[1]} -c -n 200)
# Delete final comma
sed -i '$ s/.$//' $TEMP
cat <<EOF >> $TEMP
    ],
    "mentions": [
EOF
# Add in mentions 
while read entry; do
    IFS=,  read -a tweet <<< "$entry"
    echo "        {" >> $TEMP
    echo "            \"id\": ${tweet[0]}," >> $TEMP
    echo "            \"posted_at\": \"${tweet[1]}\"," >> $TEMP
    echo "            \"screen_name\": \"${tweet[2]}\"," >> $TEMP
    echo "            \"text\": \"${tweet[3]}\"" >> $TEMP
    echo "        }," >> $TEMP
done < <(t mentions -c -n 100)

# Delete final comma
sed -i '$ s/.$//' $TEMP

cat <<EOF >> $TEMP
    ]
}
EOF

cat $TEMP

curl -X POST --include 'https://osome-botometer.p.mashape.com/2/check_account' \
     -H "X-Mashape-Key: ${APIKEY}" \
     -H 'Content-Type: application/json' \
     -H 'Accept: application/json' \
     --data-binary "@$TEMP"
