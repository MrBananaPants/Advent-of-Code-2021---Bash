#! /bin/bash

DATA=$1
FORWARD=$(cat $DATA | egrep "^forward" | sed "s/^[a-z]* //g" | sed -z "s/\n/+/g" | sed "s/+$//g")
FORWARD_TOTAL=$(echo $FORWARD | bc)
UP=$(cat $DATA | egrep "^up" | sed "s/^[a-z]* //g" | sed -z "s/\n/+/g" | sed "s/+$//g")
UP_TOTAL=$(echo $UP | bc)
DOWN=$(cat $DATA | egrep "^down" | sed "s/^[a-z]* //g" | sed -z "s/\n/+/g" | sed "s/+$//g")
DOWN_TOTAL=$(echo $DOWN | bc)

#echo "$FORWARD -> $FORWARD_TOTAL"
#echo "$UP -> $UP_TOTAL"
#echo "$DOWN -> $DOWN_TOTAL"

if [ $UP_TOTAL -gt $DOWN_TOTAL ]; then
    VERTICAL=$((UP_TOTAL - DOWN_TOTAL))
else
    VERTICAL=$((DOWN_TOTAL - UP_TOTAL))
fi

ANSWER=$((FORWARD_TOTAL * VERTICAL))

echo "$ANSWER"
