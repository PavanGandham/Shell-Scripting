#!/bin/bash

### Define Variables
declare -A resultArray

rowLength=63
columnLength=100
maxDepth=5
firstIteration=$(( $(echo 2^$maxDepth | bc) / 2 ))


## BEGIN > Fractal Function

func_fractal(){
    
    local depth=$1
    local beginRow=$2
    local beginColumn=$3
    local iteration=$4

    # Stop recursive when depth reaches 0
    [[ $depth -eq 0 ]] && return

    # Draw Trunk
    for (( r=0; r<$iteration; r++ ));
    do
        resultArray[$(( beginRow - r )),$beginColumn]="1"
    done

    # Draw Branches
    for (( c=0; c<$iteration; c++ ));
    do
        resultArray[$(( beginRow - iteration - c )),$(( beginColumn - c - 1 ))]="1"
        resultArray[$(( beginRow - iteration - c )),$(( beginColumn + c + 1 ))]="1"
    done

    ## Set Next Variables
    local nextDepth=$(( depth - 1 ))
    local nextBeginRow=$((beginRow - (iteration * 2) ))
    local nextIteration=$((iteration / 2 ))

    ## Call Fractal function for Left Branch
    func_fractal $nextDepth $nextBeginRow $((beginColumn - iteration)) $nextIteration

    ## Call Fractal funtion for Right Branch
    func_fractal $nextDepth $nextBeginRow $((beginColumn + iteration)) $nextIteration
}

## END > Fractal


## BEGIN > Main

read N

if (( N <=maxDepth )) && (( N >0 ));
then
    func_fractal $N $(( rowLength - 1)) $(( columnLength / 2 - 1 )) $firstIteration

    # Print out the Fractal Y result
    for ((r=0; r<rowLength; r++))
    do
        for ((c=0; c<columnLength; c++))
        do
            if [[ ${resultArray[$r,$c]} ]];
            then
                printf "%s" "1"
            else
                printf "%s" "_"
            fi
        done
        echo ""
    done
else
    echo "Please enter a valid DEPTH value between 1 and 5!"
fi

## END > Main