#!/bin/bash
# First Argument is for the repo you're syncing, second for the remote server's
# Gitolite hostname
for e in $(grep repo ~/Projects/gitolite-admin/conf/gitolite.conf | sed -e "s/repo //g" ); do 
    ssh $1 mirror push $2 $e &
done
wait

