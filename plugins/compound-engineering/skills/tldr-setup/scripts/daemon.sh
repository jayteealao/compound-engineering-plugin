#!/bin/bash
# Manage tldr daemon

set -e

COMMAND="${1:-status}"
PROJECT_DIR="${2:-.}"

case $COMMAND in
    start)
        echo "Starting tldr daemon for project: $PROJECT_DIR"
        tldr daemon start --project "$PROJECT_DIR"
        echo "✓ Daemon started"
        ;;
    stop)
        echo "Stopping tldr daemon..."
        tldr daemon stop
        echo "✓ Daemon stopped"
        ;;
    status)
        tldr daemon status
        ;;
    restart)
        echo "Restarting tldr daemon..."
        tldr daemon stop 2>/dev/null || true
        sleep 1
        tldr daemon start --project "$PROJECT_DIR"
        echo "✓ Daemon restarted"
        ;;
    *)
        echo "Usage: daemon.sh {start|stop|status|restart} [project_dir]"
        exit 1
        ;;
esac
