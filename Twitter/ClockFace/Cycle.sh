#!/bin/bash
THETIME=$(/home/orange/Projects/Scripts/Misc/TimeInBeats/Process.sh)
/home/orange/Projects/Scripts/Twitter/ClockFace/ClockFace.sh
while true; do
	while [ "$THETIME" != "$(/home/orange/Projects/Scripts/Misc/TimeInBeats/Process.sh)" ] ; do
		while true; do
			/home/orange/Projects/Scripts/Twitter/ClockFace/ClockFace.sh
			echo "A loop!"
			sleep 86.4
		done
	done
done
