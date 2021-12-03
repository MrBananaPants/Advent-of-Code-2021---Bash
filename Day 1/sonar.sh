#! /bin/bash

DATA=$1
LENGTH=$(cat $DATA | wc -l)
START=1
COUNTER=0
TAIL=$LENGTH
LENGTH_LESS=$((LENGTH - 1))

until [ $START -gt $LENGTH_LESS ]; do
    CURRENT_PAIR=$(tail -n $TAIL $DATA | head -n 2)
    CURRENT_VALUE=$(echo $CURRENT_PAIR | sed "s/^[0-9]*//g")
    PREVIOUS_VALUE=$(echo $CURRENT_PAIR | sed "s/[0-9]*$//g")
    if [ $CURRENT_VALUE -gt $PREVIOUS_VALUE ]; then
        ((COUNTER = COUNTER + 1))
    fi

    TAIL=$((LENGTH_LESS - START))
    ((START = START + 1))
done

echo $COUNTER
