#!/bin/bash
LOG_DIR="$HOME/terminal_logs"
TIMESTAMP="$(date +'%Y-%m-%d_%H-%M-%S')"
DATE_WORDS="$(date +'%a-%b-%d')"
LOG_FILE="${LOG_DIR}/terminal_log_${TIMESTAMP}_${DATE_WORDS}.log"

# Check if a log file already exists for the current terminal session
if [ -f "${LOG_FILE}" ]; then
    echo "Logging is already in progress for this terminal session."
else
    # Start logging the terminal session
    script -f "${LOG_FILE}"
fi
