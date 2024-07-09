#!/bin/bash

set -xe

'''
A mathematical expression containing +,-,*,^, / and parenthesis will be provided. Read in the expression, 
then evaluate it. Display the result rounded to 3 decimal places.
sample example: 5+50*3/20 + (19*2)/7
'''

read -p "Enter the Mathematical Expression:" expression

result=$(echo "scale=3; $expression" | bc -l)

printf "%.3f" "$result"
