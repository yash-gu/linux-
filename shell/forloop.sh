Your kitchen assistant is connected to a basic inventory database that lists available fruits for the day. You need to loop through this list and output a personalized message for each fruit the assistant finds.

Use a for loop to iterate over a predefined list: apple, banana, cherry, mango, orange.

For each fruit, print a message like:
"Scanning inventory... Found: apple"
"apple is fresh and ready!"

Sample Output:
Scanning inventory... Found: apple
apple is fresh and ready!
Scanning inventory... Found: banana
banana is fresh and ready!
...




---solution----
#!/bin/bash

fruits=("apple" "banana" "cherry" "mango" "orange")

for fruit in "${fruits[@]}"
do
  echo "Scanning inventory... Found: $fruit"
  echo "$fruit is fresh and ready!"
done

