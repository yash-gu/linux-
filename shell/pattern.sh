#!/bin/bash
echo "Enter the size of the pattern:"
read n
echo "Enter the type of pattern:"
echo "p1.   *"
echo "      **"
echo "      ***"
echo "         "
echo "p2.    *    "
echo "      ***   "
echo "     *****  "
echo "            "
echo "p3.   *"
echo "     **"
echo "    ***"
echo "            "
echo "p4. ***"
echo "     **"
echo "      *"



read pattern

case $pattern in
  p1)
    for ((i=1; i<=n; i++))
    do
      for ((j=n; j>i; j--))
      do
        echo -n " "
      done
      for ((k=1; k<=i; k++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
  p2)
    for ((i=1; i<=n; i++))
    do
      for ((j=n; j>i; j--))
      do
        echo -n " "
      done
      for ((k=1; k<=(2*i-1); k++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
  p3)
    for ((i=1; i<=n; i++))
    do
      for ((j=1; j<=i; j++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
  p4)
    for ((i=n; i>=1; i--))
    do
      for ((j=1; j<=i; j++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
  p6)
    for ((i=n; i>=1; i--))
    do
      for ((j=0; j<n-i; j++))
      do
        echo -n " "
      done
      for ((k=1; k<=2*i-1; k++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
 p7)
    # Upper pyramid
    for ((i=1; i<=n; i++))
    do
      for ((j=n; j>i; j--))
      do
        echo -n " "
      done
      for ((k=1; k<=(2*i-1); k++))
      do
        echo -n "*"
      done
      echo
    done
    # Lower inverted pyramid
    for ((i=n-1; i>=1; i--))
    do
      for ((j=n; j>i; j--))
      do
        echo -n " "
      done
      for ((k=1; k<=(2*i-1); k++))
      do
        echo -n "*"
      done
      echo
    done
    ;;
  *)
  
    echo "Invalid pattern option"
    ;;
esac
