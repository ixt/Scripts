#!/bin/bash
# The shebang (#!) defines what program the script is for could be a shell or
# other interpretors like python.
# Sometimes these files move across different systems, use 
# `#!/usr/bin/env bash` to better your chances to get it to work

# functions are defined like this:
function aFunction {
    # args are accessed as variables as $1 $2 etc,
    # the scripts name is at $0
    # $? is exit status of the last command (0 for success, 1 for failure, etc)
    echo $?
}
aFunction "are called like any other command" 

# Set variables with 
VARIABLE=0
STRING="0"

# Simple maths 
: (( VARIABLE += 1 ))
# or in another fucntion
echo $(( VARIABLE += 1 ))

# Create temporary files with mktemp, they will be deleted automatically
# the output is the location of the file
mktemp 

# You can set a variable to the output of the file
TEMPFILE=$(mktemp)

# pipes are useful
cat $0 | grep pipes
# ps outputs the processes started this session, -a is all by the current user
# > directs into a file and $TEMPFILE resolves to become the name of the file 
ps -a > $TEMPFILE

# >> appends to the file 
echo "last line" >> $TEMPFILE

cat <<EOF > $TEMPFILE
 The contents of a file can be wrote using variables from a script
 $VARIABLE and $STRING or even without using heredoc, and it will keep going
 until there is a line that matches the word after << with no trailing spaces.
 In this case its EOF, which is pretty common.
EOF

# bc is a nice calculator 
echo "22/7" | bc -l

# although the above is often used, echo is redundant in this case because you can use <<<
bc -l <<< "22/7"

echo " " > $TEMPFILE
# loops
i=0
until [ "$i" -gt "8" ]; do
    : (( i += 1 )) 
    echo $i >> $TEMPFILE
done

# basically read each line of file and echo each 
while read line; do
    echo $line
done < $TEMPFILE

for file in $( ls ); do
    echo $file
done

# or using seq

for i in `seq 1 10`; do
    echo $i 
done

# Chaining commands, the next is executed only if the first exits 0 (success)
grep i $TEMPFILE && echo "found a match for i"

[ "2" -gt "1" ] && echo "two is bigger than one"
[ "2" -lt "1" ] && echo "two is less than one"

# command substitution is cool, treats the output as a file
grep 2 <(seq 1 100)

# there are arrays 
array[0]="This is the content of the first"
array[1]="This is the content of the second"
array[2]="This is the content of the third"
anotherArray=(one two three four)

# all of an array
echo "${anotherArray[@]}"

# length of array
echo "${#anotherArray[@]}"

# length of the value at that index
echo "${#anotherArray[0]}"

# accessed like
echo ${array[0]}

# you can do string replacment with
echo ${array[2]/i/y}

# or global string replace with
echo ${array[2]//i/y}

# you can access normal variables like this too
anotherVariable="Another!"
echo ${anotherVariable}

# usual if then else 
if $array; then
    echo "Array!"
else 
    echo "no array!"
fi

if $array; then 
    echo "Array!"
elif $noArray; then
    echo "noArray array"
else 
    echo "no array!"
fi

# case 
case $input in
value)
    echo "what im looking for" 
    ;;
*)
    echo "everything else"
    ;;
esac

# Some other cool stuff you should know

dirname $0
basename $0
# sed 
# cut
# tail & head
# pushd & popd
# cd
# mv
# scp
# rsync
# cp

# Pad with zeros up to 6 digits
printf %06d "11"

df -h
du ~/Documents
ls -lh 
lsblk 

FS=" " read -a cuts < <(ps -a | tail -1 | xargs echo)
for cut in ${cuts[@]}; do
    echo $cut
done

# these arent usually installed but are nice
# figlet        - for bigtext
# screen        - terminal multiplexer (multiple screens in a screen)
# screenfetch   - status / specifications 
# jq            - JSON processing 
