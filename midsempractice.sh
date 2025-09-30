#!/bin/bash

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

error_exit() {
  echo -e "${RED}ERROR: $1${RESET}"
  exit 1
}

info() {
  echo -e "${CYAN}$1${RESET}"
}

success() {
  echo -e "${GREEN}$1${RESET}"
}

warn() {
  echo -e "${YELLOW}WARNING: $1${RESET}"
}
system_health_check() {
  info "Collecting system health info..."
  {
    echo "=== DISK USAGE ==="
    df -h
    echo -e "\n=== CPU INFO ==="
    lscpu
    echo -e "\n=== MEMORY USAGE ==="
    free -h
  } > system_report.txt
  success "Report saved to system_report.txt"
  info "First 10 lines of system_report.txt:"
  head -n 10 system_report.txt
}
active_processes() {
  ps aux
  read -p "Enter a keyword to filter process list: " keyword
  if [[ -z "$keyword" ]]; then
    warn "No keyword entered, showing all processes."
    return
  fi
  echo
  info "Filtered results for \"$keyword\":"
  matched=$(ps aux | grep "$keyword" | grep -v grep)
  echo "$matched"
  count=$(echo "$matched" | wc -l)
  success "Total matching processes: $count"
}

user_group_mgmt() {
  if [[ $EUID -ne 0 ]]; then
    warn "This operation may require root privileges."
  fi
  read -p "Enter a new username: " username
  # Check username validity
  if [[ -z "$username" ]]; then error_exit "Username cannot be empty."; fi
  id "$username" &>/dev/null
  if [[ $? -eq 0 ]]; then error_exit "Username already exists."; fi
  read -p "Enter new group name: " groupname
  if [[ -z "$groupname" ]]; then error_exit "Group name cannot be empty."; fi
  sudo groupadd "$groupname"
  sudo useradd -m -G "$groupname" "$username"
  echo "$username:default123" | sudo chpasswd
  sudo touch testfile.txt
  sudo chown "$username:$groupname" testfile.txt
  success "User '$username' and group '$groupname' created, testfile ownership set."
}
file_organizer() {
  read -p "Enter target directory path: " dir
  if [[ ! -d "$dir" ]]; then error_exit "Directory does not exist."; fi

  mkdir -p "$dir/images" "$dir/docs" "$dir/scripts"
  # Move files by extension
  mv "$dir"/*.jpg "$dir"/images/ 2>/dev/null
  mv "$dir"/*.png "$dir"/images/ 2>/dev/null
  mv "$dir"/*.txt "$dir"/docs/ 2>/dev/null
  mv "$dir"/*.md "$dir"/docs/ 2>/dev/null
  mv "$dir"/*.sh "$dir"/scripts/ 2>/dev/null

  if command -v tree &>/dev/null; then
    tree "$dir"
  else
    warn "tree not installed, listing with 'ls -R' instead:"
    ls -R "$dir"
  fi
  success "Files organized."
}

network_diag() {
  info "Running ping to google.com..."
  ping -c 3 google.com > network_report.txt 2>&1
  echo -e "\n===== DNS Lookup =====" >> network_report.txt
  dig google.com >> network_report.txt 2>&1
  echo -e "\n===== HTTP Headers =====" >> network_report.txt
  curl -I https://example.com >> network_report.txt 2>&1

  success "Network diagnostics done. See network_report.txt."
  head -n 15 network_report.txt
}
setup_cron() {
  read -p "Enter the script absolute path: " script_path
  if [[ ! -f "$script_path" ]]; then error_exit "Script does not exist."; fi
  read -p "Enter minute (0-59): " minute
  read -p "Enter hour (0-23): " hour
  if ! [[ "$minute" =~ ^[0-9]{1,2}$ && "$minute" -ge 0 && "$minute" -le 59 ]]; then error_exit "Minute out of range."; fi
  if ! [[ "$hour" =~ ^[0-9]{1,2}$ && "$hour" -ge 0 && "$hour" -le 23 ]]; then error_exit "Hour out of range."; fi

  cronjob="$minute $hour * * * $script_path"
  (crontab -l 2>/dev/null; echo "$cronjob") | crontab -
  success "Cron job added: runs $script_path at $hour:$minute daily."
}
ssh_key_setup() {
  read -p "Enter key file name (default: id_rsa): " keyfile
  keyfile=${keyfile:-id_rsa}
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/$keyfile -N "" || error_exit "SSH keygen failed."
  success "SSH key generated as ~/.ssh/$keyfile.pub"
  echo "Public key:"
  cat ~/.ssh/$keyfile.pub
  echo
  info "To copy this key to a remote server: use 'ssh-copy-id -i ~/.ssh/$keyfile.pub user@server'"
}
exit_script() {
  success "Goodbye!"
  exit 0
}
while true; do
  echo
  echo -e "${CYAN}========= ADMIN TOOLKIT MENU =========${RESET}"
  echo -e "${YELLOW}1) System Health Check"
  echo "2) Active Processes"
  echo "3) User & Group Management"
  echo "4) File Organizer"
  echo "5) Network Diagnostics"
  echo "6) Scheduled Task Setup (cron)"
  echo "7) SSH Key Setup"
  echo "8) Exit${RESET}"
  echo -n "Enter your choice [1-8]: "
  read choice

  case "$choice" in
    1) system_health_check ;;
    2) active_processes ;;
    3) user_group_mgmt ;;
    4) file_organizer ;;
    5) network_diag ;;
    6) setup_cron ;;
    7) ssh_key_setup ;;
    8) exit_script ;;
    *) warn "Invalid option. Please enter 1-8." ;;
  esac
done

# End of script
