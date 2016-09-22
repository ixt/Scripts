#!/bin/bash
t set name "$(cat /home/chip/Scripts/Twitter/AutoOrangeNames/orangenames.txt | shuf | head -1)"
