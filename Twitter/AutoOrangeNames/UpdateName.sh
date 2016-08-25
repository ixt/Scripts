#!/bin/bash
t set name "$(cat /home/chip/Scripts/AutoOrangeNames/orangenames.txt | shuf | head -1)"
