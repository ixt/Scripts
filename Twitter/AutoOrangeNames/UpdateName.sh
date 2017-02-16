#!/bin/bash
t set name "$(cat /home/orange/Projects/Scripts/Twitter/AutoOrangeNames/orangenames.txt | shuf | head -1)"
