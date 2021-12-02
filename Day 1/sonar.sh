#! /bin/bash

DATA=$1
LENGTE=$(cat $DATA | wc -l )
START=1
COUNTER=0
TAIL=$LENGTE
MINDER=$((LENGTE-1))

until [ $START -gt $MINDER ]
do
    HUIDIG=$(tail -n $TAIL $DATA | head -n 2)
    HUIDIGEWAARDE=$(echo $HUIDIG | sed "s/^[0-9]*//g")
    VORIGEWAARDE=$(echo $HUIDIG | sed "s/[0-9]*$//g")
    if [ $HUIDIGEWAARDE -gt $VORIGEWAARDE ]; 
        then
            ((COUNTER=COUNTER+1))
        fi

    TAIL=$((LENGTE-START))
    ((START=START+1))
done

echo $COUNTER