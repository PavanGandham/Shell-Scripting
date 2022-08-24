#!/usr/bin/bash

# https://github.com/ssbostan/devops-bash-scripts

VERBOSE_OUTPUT=0
ADD_DATE_TO_FILENAME=""

usage() {
    cat <<EOL
Usage: $0 [OPTIONS] <source_dir> <backup_name>
Options:
    -v              : Verbose mode.
    --date <format> : Add date to the backup filename.
                      Supported formats: time, date, datetime, timestamp
EOL
}

if [[ $# -lt 2 ]]; then
    usage
    exit 1
fi

while true; do
    case $1 in
    -v)
        VERBOSE_OUTPUT=1
        shift 1
        ;;
    --date)
        case $2 in
        time)
            ADD_DATE_TO_FILENAME=$(date +%H%M%S)
            ;;
        date)
            ADD_DATE_TO_FILENAME=$(date +%Y%m%d)
            ;;
        datetime)
            ADD_DATE_TO_FILENAME=$(date +%Y%m%d-%H%M%S)
            ;;
        timestamp)
            ADD_DATE_TO_FILENAME=$(date +%s)
            ;;
        *)
            echo "ERROR: Unsupported date format."
            exit 1
            ;;
        esac
        shift 2
        ;;
    *)
        break
        ;;
    esac
done

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

if [[ ! -d "$1" ]]; then
    echo "ERROR: $1 should be a directory."
    exit 1
fi

if [[ "$2" != *.tar.gz ]]; then
    echo "ERROR: $2 should be something with .tar.gz extension."
    exit 1
fi

if [[ $VERBOSE_OUTPUT -eq 0 ]]; then
    if [[ $ADD_DATE_TO_FILENAME == "" ]]; then
        tar -zcf $2 $1 &>/dev/null
    else
        tar -zcf "${ADD_DATE_TO_FILENAME}-${2}" $1 &>/dev/null
    fi
else
    if [[ $ADD_DATE_TO_FILENAME == "" ]]; then
        tar -zvcf $2 $1
    else
        tar -zvcf "${ADD_DATE_TO_FILENAME}-${2}" $1
    fi
fi

if [[ ! -f "$2" ]]; then
    echo "ERROR: Could not create the backup file."
    exit 1
fi

echo "INFO: Backup is created successfully."

# How to use:
# Usage: backup [OPTIONS] <source_dir> <backup_name>
# Options:
#     -v              : Verbose mode.
#     --date <format> : Add date to the backup filename.
#                       Supported formats: time, date, datetime, timestamp
#backup --date datetime /opt mybackup.tar.gz