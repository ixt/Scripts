#!/bin/bash
PROCESS=""
play() {
	VAL=$(ls -1 *.mkv | shuf | head -1)
	screen -dm mpv $VAL --no-video 
	PROCESS=$(ps -aux | grep -e "mpv" | grep video | xargs echo | cut -d" " -f2 | head -1)
	echo "Playing $VAL"
}

echo 0 > /sys/class/gpio/gpio25/value 
while true; do
	if [ "$(cat /sys/class/gpio/gpio23/value)" -eq "0" ]; then 
		echo 1 > /sys/class/gpio/gpio25/value
		play 
		while [ "$(cat /sys/class/gpio/gpio23/value)" -eq "0" ]; do
			sleep 1s
		done
		sleep 1s
		while [ $(ps -p $PROCESS | wc -l) -eq "2" ]; do
			[ "$(cat /sys/class/gpio/gpio23/value)" -eq "0" ] && pkill mpv
			sleep 0.1s
		done
		echo 0 > /sys/class/gpio/gpio25/value 
	fi 
	sleep 0.1s
done
