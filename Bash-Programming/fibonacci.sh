#!/bin/bash

set -xe

# Program for Fibonacci Series

# Static Input of N
read -p "Enter the max static input for Fibonacci series : " N

if $N >0; then
    # First Number of series
    a=0
    # Second Number of series
    b=1
    echo "The Fibonacci Series is : "
    for ((i = 0; i < $N; i++)); do
        echo -n "$a"
        fn=$((a + b))
        a=$b
        b=$fn
    done
else
    echo "Entered N value is not valid , should be non zero !!"
fi
