#!/bin/bash
t set name "$(cat /home/pi/orangenames.txt | shuf | head -1)"
