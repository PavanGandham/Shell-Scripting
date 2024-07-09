#!/bin/bash

set -xe

'''
Print the odd natural numbers from the given range of number that needs to be take as an input
example:
1
3
5
7
.
.
.
99
'''

read -p "Enter the first number in range:" start_num
read -p "Enter the last number in the range:" last_num

for num in {start_num..last_num}; do
if [ $(expr $num % 2) -ne 0 ]; then
echo "$num"
fi
done