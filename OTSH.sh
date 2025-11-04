
#!/bin/bash

CONFIG_FILE="$HOME/.otssh_config"

usage() {
    echo "Usage:"
    echo "  $0 -a -n <name> -h <host> -u <user> [-p <port>] [-i <identity_file>]"
    echo "  $0 -u -n <name> -h <host> -u <user> [-p <port>] [-i <identity_file>]"
    echo "  $0 ls [-d]"
    echo "  $0 rm <name>"
    echo "  $0 <name>"
    exit 1
}

add_connection() {
    grep -v "^$name:" "$CONFIG_FILE" 2>/dev/null > "$CONFIG_FILE.tmp" || true
    echo "$name:$host:$user:$port:$identity" >> "$CONFIG_FILE.tmp"
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "Added/Updated $name"
}

list_connections() {
    if [[ $detailed == true ]]; then
        while IFS=: read -r NAME HOST USER PORT ID; do
            SSH_CMD="ssh"
            [[ $ID != "" ]] && SSH_CMD+=" -i $ID"
            [[ $PORT != "" ]] && SSH_CMD+=" -p $PORT"
            SSH_CMD+=" $USER@$HOST"
            echo "$NAME: $SSH_CMD"
        done < "$CONFIG_FILE"
    else
        cut -d: -f1 "$CONFIG_FILE"
    fi
}

remove_connection() {
    grep -v "^$1:" "$CONFIG_FILE" > "$CONFIG_FILE.tmp"
    mv "$CONFIG_FILE.tmp" "$CONFIG_FILE"
    echo "Removed $1"
}

connect_server() {
    entry=$(grep "^$1:" "$CONFIG_FILE")
    if [[ "$entry" == "" ]]; then
        echo "[ERROR]: Server information is not available, please add server first."
        exit 1
    fi
    NAME=$(echo "$entry" | cut -d: -f1)
    HOST=$(echo "$entry" | cut -d: -f2)
    USER=$(echo "$entry" | cut -d: -f3)
    PORT=$(echo "$entry" | cut -d: -f4)
    ID=$(echo "$entry" | cut -d: -f5)
    SSH_CMD="ssh"
    [[ $ID != "" ]] && SSH_CMD+=" -i $ID"
    [[ $PORT != "" ]] && SSH_CMD+=" -p $PORT"
    SSH_CMD+=" $USER@$HOST"
    echo "Connecting to $NAME on port ${PORT:-22} as $USER${ID:+ via $ID key}."
    exec $SSH_CMD
}

if [[ $# -lt 1 ]]; then
    usage
fi

case "$1" in
    -a)
        shift
        while [[ $# -gt 0 ]]; do
            case $1 in
                -n) name="$2"; shift 2 ;;
                -h) host="$2"; shift 2 ;;
                -u) user="$2"; shift 2 ;;
                -p) port="$2"; shift 2 ;;       # Port is saved as-is, unchecked!
                -i) identity="$2"; shift 2 ;;
                *) shift ;;
            esac
        done
        [[ -z $name || -z $host || -z $user ]] && usage
        add_connection     # Doesn't check if config file is writable!
        ;;
    -u)
        shift
        while [[ $# -gt 0 ]]; do
            case $1 in
                -n) name="$2"; shift 2 ;;
                -h) host="$2"; shift 2 ;;
                -u) user="$2"; shift 2 ;;
                -p) port="$2"; shift 2 ;;       # Port is saved as-is, unchecked!
                -i) identity="$2"; shift 2 ;;
                *) shift ;;
            esac
        done
        [[ -z $name || -z $host || -z $user ]] && usage
        add_connection     # Doesn't check if config file is writable!
        ;;
    ls)
        detailed=false
        [[ "$2" == "-d" ]] && detailed=true
        list_connections
        ;;
    rm)
        [[ -z $2 ]] && usage
        remove_connection "$2"
        ;;
    *)
        connect_server "$1"
        ;;
esac
