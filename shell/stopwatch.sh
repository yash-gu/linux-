You’re adding a stopwatch function to the assistant that counts up from 1 to a given number (e.g., 5 seconds) to track how long something has been running.

Use a while loop to start from 1 and count up to 5.
Print each second like: "Stopwatch: 1 second elapsed"
At the end, print: "Stopwatch complete!"

Sample output:
Stopwatch: 1 second elapsed
Stopwatch: 2 seconds elapsed
Stopwatch: 3 seconds elapsed
Stopwatch: 4 seconds elapsed
Stopwatch: 5 seconds elapsed
Stopwatch complete!





---solution------
#!/bin/bash


seconds=1
while [ $seconds -le 5 ]
do
        echo "Stopwatch: $seconds second elapsed"
  sleep 1
  seconds=$((seconds + 1))
done

echo "Stopwatch complete!"

