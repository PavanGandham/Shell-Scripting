#!/bin/bash

read -p "Provide 3 persons names : " -a Names
count=${#Names[@]}
if [[ $count == 3 ]]; then
    for i in ${Names[@]}; do
        echo $i >> out.txt
        cat out.txt
        # >out.txt
    done
elif [[ $count < 3 ]]; then
    echo "Incorrect no.of inputs gave only $count. Please give exact 3 inputs"
else
    echo "Incorrect no.of inputs, gave more than required inputs i.e, $count"
fi
