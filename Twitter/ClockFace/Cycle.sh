#!/bin/bash
THETIME=$(~/Scripts/Misc/TimeInBeats/Process.sh)
~/Scripts/Twitter/ClockFace/ClockFace.sh
while true; do
	while [ "$THETIME" != "$(~/Scripts/Misc/TimeInBeats/Process.sh)" ] ; do
		while true; do
			~/Scripts/Twitter/ClockFace/ClockFace.sh
			echo "A loop!"
			sleep 86.4
		done
	done
done
