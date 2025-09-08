#!/bin/bash

echo "Simple Calculator"
echo "Enter first number:"
read num1
echo "Enter operator (+, -, *, /):"
read op
echo "Enter second number:"
read num2

case $op in
    +) result=$(echo "$num1+$num2" | bc);;
    -) result=$(echo "$num1-$num2" | bc);;
    \*) result=$(echo "$num1*$num2" | bc);;
    /) result=$(echo "scale=2; $num1/$num2" | bc);;
    *) echo "Invalid operator." ; exit 1;;
esac

echo "Result: $result"
