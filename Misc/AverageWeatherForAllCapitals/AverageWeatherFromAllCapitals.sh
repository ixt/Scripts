#!/bin/bash
cd $(dirname $0)

# List of countries and coords from 
if [ ! -e latlng ]; then
    wget -qO- https://restcountries.eu/rest/v2/all | jq -r ".[] | .latlng" | sed -e "s/\[//g;s/\]//g;/^$/d" -e "N;s/\n//g;s/\s//g" > latlng
fi

# Weather API used is DARKSKYAPI
DARKSKYAPIKEY=""

## Get newest data on all countries via Dark Sky
rm currently/*
while read entry; do
    wget -qO- https://api.darksky.net/forecast/$DARKSKYAPIKEY/$entry?exclude=minutely,hourly,daily,alerts,flags > currently/$entry
done < latlng

# Projection https://upload.wikimedia.org/wikipedia/commons/e/e3/Fuller_projection.svg
#if [ ! -e Fuller_projection.svg ]; then
#    wget https://upload.wikimedia.org/wikipedia/commons/e/e3/Fuller_projection.svg
#fi

# Make a mean temperature
TEMP=$(mktemp)
VALUE="0"
while read file; do
    VALUE=$(bc -l <<< "$(jq -r ".currently.temperature" currently/$file) + $VALUE")
done < <(ls -1 currently/)
F=$(bc -l <<< "scale=0;$VALUE / $(ls -1 currently/ | wc -l)")
C=$(cut -d"." -f1 <<< "$(bc -l <<< "scale=2;(5/9)*($F-32)")")

# Make a mean precipitation probability
VALUE="0"
while read file; do
    VALUE=$(bc -l <<< "$(jq -r ".currently.precipProbability" currently/$file) + $VALUE")
done < <(ls -1 currently/)
PRECIPPROB=$(cut -d"." -f1 <<< "$(echo "scale=2;$(bc -l <<< "scale=2;$VALUE / $(ls -1 currently/ | wc -l)") * 100" | bc -l)")

# Make a mode of the summaries and precipitation type
SUMMARY=$(jq -r ".currently.summary" currently/* | sort | uniq -c | sort -n | tail -1 | xargs echo | cut -d" " -f2)
PRECIPTYPE=$(sed -e 's/\b[a-z]/\u&/g' <<< "$(jq -r ".currently.precipType" currently/* | sort | uniq -c | sort -n | tail -1 | xargs echo | cut -d" " -f2)" )
# Fix if result is null
if [[ "$SUMMARY" == "null" ]]; then SUMMARY=$(jq -r ".currently.summary" currently/* | sort | uniq -c | sort -n | tail -2 | head -1 | xargs echo | cut -d" " -f2); fi
if [[ "$PRECIPTYPE" == "Null" ]]; then PRECIPTYPE=$(sed -e 's/\b[a-z]/\u&/g' <<< "$(jq -r ".currently.precipType" currently/* | sort | uniq -c | sort -n | tail -2 | head -1 | xargs echo | cut -d" " -f2)" ); fi

# Compose tweet
cat << EOF >$TEMP 
The Weather is currently $C°C / $F°F
$SUMMARY with a $PRECIPPROB% chance of $PRECIPTYPE
#AverageWeather Powered by Dark Sky
EOF

# Assemble map
#sed -e"s/c8ebff/ffffff/g;s/fefee4/$newTemp/g;s/0978ab/$newTemp/g;s/000000/ffffff/g" Fuller_projection.svg > newmap.svg

t update "$(cat $TEMP)"
cd -
