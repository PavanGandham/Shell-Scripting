#!/bin/bash

read N
numbers=()
sum=0
n=0

if [[ $N -le 1 || $N -le 500 ]]; then
while [[ $n -lt $N ]]
do
read number
sum=$((sum+number))
n=$((n+1))
done

avg=$(echo "scale=4; $sum / $N" | bc)
printf "%.3f" "$avg"
fi