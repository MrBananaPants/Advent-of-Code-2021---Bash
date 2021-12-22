#! /bin/bash

POSITION_PLAYER1=$(cat $1 | grep "Player 1" | grep . -o | tail -n 1)
POSITION_PLAYER2=$(cat $1 | grep "Player 2" | grep . -o | tail -n 1)
SCORE_PLAYER1=0
SCORE_PLAYER2=0

#POSITION_PLAYER1=4
#POSITION_PLAYER2=8

AMOUNT_OF_ROLLS=0

DICE_NUMBER1=0
DICE_NUMBER2=0
DICE_NUMBER3=0

while [ $SCORE_PLAYER1 -lt 1000 ] && [ $SCORE_PLAYER2 -lt 1000 ]; do
    DICE_NUMBER1=$((DICE_NUMBER1 + 1))
    DICE_NUMBER2=$((DICE_NUMBER2 + 2))
    DICE_NUMBER3=$((DICE_NUMBER3 + 3))
    WHICH_PLAYER_TURN=$(echo "$AMOUNT_OF_ROLLS%2" | bc)
    #if it's player 1's turn
    if [ $WHICH_PLAYER_TURN -eq 0 ]; then
        POSITION_PLAYER1=$(echo "$POSITION_PLAYER1+$DICE_NUMBER1+$DICE_NUMBER2+$DICE_NUMBER3" | bc | grep . -o | tail -n 1)
        if [ $POSITION_PLAYER1 -eq 0 ]; then
            POSITION_PLAYER1=10
        fi
        SCORE_PLAYER1=$(echo "$SCORE_PLAYER1+$POSITION_PLAYER1" | bc)
        echo "Player 1 rolls $DICE_NUMBER1+$DICE_NUMBER2+$DICE_NUMBER3 and moves to space $POSITION_PLAYER1 for a total score of $SCORE_PLAYER1."
    fi
    #if it's player 2's turn
    if [ $WHICH_PLAYER_TURN -ne 0 ]; then
        POSITION_PLAYER2=$(echo "$POSITION_PLAYER2+$DICE_NUMBER1+$DICE_NUMBER2+$DICE_NUMBER3" | bc | grep . -o | tail -n 1)
        if [ $POSITION_PLAYER2 -eq 0 ]; then
            POSITION_PLAYER2=10
        fi
        SCORE_PLAYER2=$(echo "$SCORE_PLAYER2+$POSITION_PLAYER2" | bc)
        echo "Player 2 rolls $DICE_NUMBER1+$DICE_NUMBER2+$DICE_NUMBER3 and moves to space $POSITION_PLAYER2 for a total score of $SCORE_PLAYER2."
    fi

    DICE_NUMBER1=$DICE_NUMBER3
    DICE_NUMBER2=$DICE_NUMBER3
    AMOUNT_OF_ROLLS=$((AMOUNT_OF_ROLLS + 3))
done

echo "number of rolls = $AMOUNT_OF_ROLLS"

if [ $SCORE_PLAYER1 -lt 1000 ]; then
    ANSWER=$(echo "$SCORE_PLAYER1*$AMOUNT_OF_ROLLS" | bc)
    echo "Answer = $ANSWER"
fi

if [ $SCORE_PLAYER2 -lt 1000 ]; then
    ANSWER=$(echo "$SCORE_PLAYER2*$AMOUNT_OF_ROLLS" | bc)
    echo "Answer = $ANSWER"

fi
