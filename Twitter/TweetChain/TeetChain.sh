#!/usr/bin/env bash
# Ugly but working code

working_dir=$(dirname $0)
tweet=$(head -n 1 $1)
tail -n +2 $1 | tee $1 
if [ -e "$working_dir/last_id" ]; then
    last_id=$(cat $working_dir/last_id)
    new_id=$(t update "$tweet https://twitter.com/_xs/status/$last_id" | grep delete | sed -e "s/[^0-9]*//g")
    echo $new_id > $working_dir/last_id
else
    last_id=$(t update "$tweet" | grep delete | sed -e "s/[^0-9]*//g")
    echo $last_id > $working_dir/last_id
fi
