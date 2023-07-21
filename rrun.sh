#!/bin/bash

print_help() {
    echo "Usage: rrun [options] <remote_script_name> [arguments]"
    echo "Options:"
    echo "  -h, --help         Show this help message and exit"
    echo "  -u, --url <url>    Use a custom URL instead of rrun.sh"
}

BASE_URL="https://rrun.sh/sh"

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            print_help
            exit 0
            ;;
        -u|--url)
            shift
            BASE_URL="$1"
            ;;
        *)
            break
            ;;
    esac
    shift
done

if [[ $# -lt 1 ]]; then
    echo "Error: Remote script name is required."
    print_help
    exit 1
fi

REMOTE_SCRIPT_NAME="$1"
shift

REMOTE_SCRIPT_URL="$BASE_URL/$REMOTE_SCRIPT_NAME"

LOCAL_SCRIPT_PATH="/tmp/${REMOTE_SCRIPT_NAME}"
curl -sSL "$REMOTE_SCRIPT_URL" -o "$LOCAL_SCRIPT_PATH"
chmod +x "$LOCAL_SCRIPT_PATH"

"$LOCAL_SCRIPT_PATH" "$@"

rm -f "$LOCAL_SCRIPT_PATH"

