#! /bin/bash

INPUT=$(cat $1)
MAX_VALUE=$(sed "s/,/ /g" <<<"$INPUT" | grep -Eo '[0-9]+' | sort -rn | head -n 1)
LIST_VALUES=$(sed "s/,/\n/g" <<<"$INPUT")
NUMBER_OF_LINES=$(echo "$LIST_VALUES" | wc -l)

CURRENT_TOTAL_FUEL=0
HORIZONTAL_LEVEL=0
SUBTRACTION=-1
CURRENT_VALUE=0
COUNTER=1

#Keep repeating until every possible solution has been found
while [ $CURRENT_VALUE -le $MAX_VALUE ]; do

    while [ $COUNTER -le $NUMBER_OF_LINES ]; do
        LINE=$(cat $1 | sed "s/,/\n/g" | head -"$COUNTER" | tail -1)
        if [ "$LINE" > "$HORIZONTAL_LEVEL" ]; then
            MATH=$(echo "$LINE-$HORIZONTAL_LEVEL")
            SUBTRACTION=$(bc <<<$MATH)
        fi
        if [ "$LINE" < "$HORIZONTAL_LEVEL" ]; then
            MATH=$(echo "$HORIZONTAL_LEVEL-$LINE")
            SUBTRACTION=$(bc <<<$MATH)
        fi
        CURRENT_TOTAL_FUEL=$((CURRENT_TOTAL_FUEL + SUBTRACTION))
        echo "Move from $LINE to $HORIZONTAL_LEVEL: $SUBTRACTION fuel"
        SUBTRACTION=0
        COUNTER=$((COUNTER + 1))
    done

    HORIZONTAL_LEVEL=$((HORIZONTAL_LEVEL + 1))

    if [ $CURRENT_VALUE -eq 0 ]; then
        TOTAL_FUEL_SMALLEST=$CURRENT_TOTAL_FUEL
    fi

    if [ $CURRENT_TOTAL_FUEL -lt $TOTAL_FUEL_SMALLEST ]; then
        TOTAL_FUEL_SMALLEST=$CURRENT_TOTAL_FUEL
    fi
    CURRENT_TOTAL_FUEL=0
    CURRENT_VALUE=$((CURRENT_VALUE + 1))
    COUNTER=0

done
echo "---------------------------------"
echo "Result = $TOTAL_FUEL_SMALLEST"
