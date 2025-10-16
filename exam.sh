#!/bin/bash

# SYSTEM MANAGEMENT SCRIPT 

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# FUNCTIONS
add_users(){
    file="$1"
    if [ ! -f "$file" ]; then
        echo -e "${RED}File not found: $file${RESET}"
        exit 1
    fi
    while read -r username; do
        if id "$username" &>/dev/null; then
            echo -e "${YELLOW}User $username already exists${RESET}"
        else
            sudo useradd -m "$username" && echo -e "${GREEN}User $username created${RESET}"
        fi
    done < "$file"
}

system_project(){
    user="$1"
    num="$2"
    homedir="/home/$user/projects"
    if ! id "$user" &>/dev/null; then
        echo -e "${RED}USER: $user - Does not exist${RESET}"
        exit 1
    fi
    sudo mkdir -p "$homedir"
    for ((i=1; i<=num; i++)); do
        dir="$homedir/project$i"
        sudo mkdir -p "$dir"
        echo "project$i created by $user on $(date)" | sudo tee "$dir/README.txt" > /dev/null
        sudo chmod 755 "$dir"
        sudo chmod 640 "$dir/README.txt"
    done
}

sys_report(){
    outputfile="$1"
    date=$(date)
    {
        echo "==== SYSTEM REPORT ===="
        echo "Edited on ($date)"
        echo "DISK USAGE"
        df -h
        echo "MEMORY INFO"
        free -h
        echo "CPU INFO"
        lscpu
        echo "TOP 5 MEMORY PROCESSES"
        ps aux --sort=-%mem | head -n 6
        echo "TOP 5 CPU PROCESSES"
        ps aux --sort=-%cpu | head -n 6
    } > "$outputfile"
}
process_management(){
    user="$1"
    action="$2"

    case $action in
        list_zombie)
            ps -u "$user" | grep 'Z'
            ;;
        list_processes)
            ps -u "$user"
            ;;
        list_stopped)
            ps -u "$user" | grep 'T'
            ;;
        kill_zombie)
            echo -e "${RED}Zombie processes cannot be killed directly${RESET}"
            ;;
        kill_stopped)
            echo "Killing all stopped processes for user $user..."
            ps -u "$user" | awk '$8=="T" {print $2}' | xargs -r sudo kill
            echo "Done."
            ;;
        *)
            echo -e "${YELLOW}Invalid action specified${RESET}"
            ;;
    esac
}

perm_owner(){
    user="$1"
    path="$2"
    perms="$3"
    owner="$4"
    group="$5"

    if [ ! -e "$path" ]; then
        echo -e "${RED}Path $path not found.${RESET}"
        exit 1
    fi
    sudo chmod -R "$perms" "$path" && sudo chown -R "$owner":"$group" "$path"
}

show_help(){
    echo -e "${YELLOW}Usage Examples:${RESET}"
    echo "./exam.sh add_users users.txt"
    echo "./exam.sh setup_projects alice 5"
    echo "./exam.sh sys_report sysinfo.txt"
    echo "./exam.sh process_manage bob list_zombie"
    echo "./exam.sh perm_owner alice /home/alice/projects 755 alice alice"
    echo "./exam.sh help"
}

case "$1" in
    add_users)
        add_users "$2"
        ;;
    setup_projects)
        system_project "$2" "$3"
        ;;
    sys_report)
        sys_report "$2"
        ;;
    process_manage)
        process_management "$2" "$3"
        ;;
    perm_owner)
        perm_owner "$2" "$3" "$4" "$5" "$6"
        ;;
    help)
        show_help
        ;;
    *)
        echo -e "${RED}Invalid command. Use './exam.sh help' to see usage.${RESET}"
        exit 1
        ;;
esac

