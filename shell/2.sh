// Write a script that will check the number of executions of that script, last User that executed the script and the time and date at which it was executed
#!/bin/bash
logfile="$HOME/.myscript"

if [ ! -f "$logfile" ]; then
    echo "COUNT=0" > "$logfile"
    echo "USER=" >> "$logfile"
    echo "TIME=" >> "$logfile"
fi

source "$logfile"

prev_count=$COUNT
prev_user=$USER
prev_time=$TIME

COUNT=$((prev_count + 1))
USER=$(whoami)
TIME=$(date '+%Y-%m-%d %H:%M:%S')

{
    echo "COUNT=$COUNT"
    echo "USER=\"$USER\""
    echo "TIME=\"$TIME\""
} > "$logfile"

echo "Previous executions: $prev_count"
echo "Previous user: $prev_user"
echo "Previous time: $prev_time"
echo "------------"
echo "Current user: $USER"
echo "Current time: $TIME"
echo "Current count: $COUNT"
