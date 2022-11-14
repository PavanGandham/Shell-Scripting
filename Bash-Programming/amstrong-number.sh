#!/bin/bash

set -e

read -p "Enter the Number : " n
t=$n
s=0
b=0
c=10
# echo ${#n}
while [ $n -gt $b ]; do
    r=$(expr $n % $c)
    echo $r
    # i=$[$r**${#n}]
    i=$(expr $r \* $r \* $r)
    # echo $i
    s=$(expr $s + $i)
    # echo $s
    n=$(expr $n / $c)
    echo $n
done
echo $s
if [[ $s -eq $t ]]; then
    echo "The Given Number $n is Amstrong number"
else
    echo "The Given Number $n is not an Astrong number"
fi
