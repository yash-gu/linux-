#!/bin/bash

print_usage() {
    echo "Usage:"
    echo "$0 addDir <path> <dirname>"
    echo "$0 deleteDir <path> <dirname>"
    echo "$0 listFiles <path>"
    echo "$0 listDirs <path>"
    echo "$0 listAll <path>"
}

if [ $# -lt 1 ]; then
    print_usage
    exit 1
fi

case "$1" in
    addDir)
        if [ $# -ne 3 ]; then
            echo "Error: addDir requires <path> and <dirname>"
            print_usage
            exit 1
        fi
        mkdir -p "$2/$3"
        if [ $? -eq 0 ]; then
            echo "Directory created: $2/$3"
        else
            echo "Failed to create directory: $2/$3"
            exit 1
        fi
        ;;
    deleteDir)
        if [ $# -ne 3 ]; then
            echo "Error: deleteDir requires <path> and <dirname>"
            print_usage
            exit 1
        fi
        rm -rf "$2/$3"
        if [ $? -eq 0 ]; then
            echo "Directory deleted: $2/$3"
        else
            echo "Failed to delete directory: $2/$3"
            exit 1
        fi
        ;;
    listFiles)
        if [ $# -ne 2 ]; then
            echo "Error: listFiles requires <path>"
            print_usage
            exit 1
        fi
        find "$2" -mindepth 1 -maxdepth 1 -type f -printf "%f\n"
        ;;
    listDirs)
        if [ $# -ne 2 ]; then
            echo "Error: listDirs requires <path>"
            print_usage
            exit 1
        fi
        find "$2" -mindepth 1 -maxdepth 1 -type d -printf "%f\n"
        ;;
    listAll)
        if [ $# -ne 2 ]; then
            echo "Error: listAll requires <path>"
            print_usage
            exit 1
        fi
        ls -1 "$2"
        ;;
    *)
        echo "Invalid command: $1"
        print_usage
        exit 1
        ;;
esac
