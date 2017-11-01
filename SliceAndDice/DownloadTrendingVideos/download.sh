#!/bin/bash
# Script by dundua
# https://www.reddit.com/r/DataHoarder/comments/672t9r/my_youtubedl_script_for_incremental_channel_backup/dgndsy4/
LOGFILE="$PWD/$(date +"%Y-%m-%d-%H-%M-%S.%N").log"
exec 3>&1 4>&2 >>$LOGFILE 2>&1
youtube-dl --verbose --write-auto-sub --ignore-errors --no-continue --no-overwrites --keep-video --no-post-overwrites --download-archive archive.txt --write-description --write-info-json --write-annotations --write-thumbnail --output "%(uploader)s (%(uploader_id)s)/%(id)s/%(title)s - %(upload_date)s.%(ext)s" -f bestvideo[ext=mp4]+bestaudio[ext=m4a] -- $1
