#! /bin/bash

LENGTH=$(cat $1 | wc -l)
WIDTH=$(cat $1 | head -n 1 | wc -m)
((HALF_LENGTH = LENGTH / 2))

START=1

while [ $START -lt $WIDTH ]; do
    SUM=$(cut -b $START $1 | tr '\n' '+' | sed "s/+$//g")
    SUM=$(echo $SUM | bc)
    if [ $SUM -gt $HALF_LENGTH ]; then
        RESULT+=1
    else
        RESULT+=0
    fi
    ((START++))
done

RESULT_INVERSE=$(tr '01' '10' <<<"$RESULT")
RESULT_DECIMAL=$(echo "$((2#$RESULT))")
RESULT_INVERSE_DECIMAL=$(echo "$((2#$RESULT_INVERSE))")

((FINAL_RESULT = RESULT_DECIMAL * RESULT_INVERSE_DECIMAL))
echo "$FINAL_RESULT"
