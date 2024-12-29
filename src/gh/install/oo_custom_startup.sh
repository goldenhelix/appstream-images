#!/usr/bin/env bash
set -ex

# Wait for the desktop to be ready
/usr/bin/desktop_ready

for f in $HOME/Desktop/*.desktop; do 
    chmod +x "$f"; gio set -t string "$f" metadata::xfce-exe-checksum "$(sha256sum "$f" | awk '{print $1}')"
done

# if there is a FULLSCREEN argument, start the fullscreen script
if [ "$FULLSCREEN" = "true" ]; then
    echo "Starting fullscreen script"
    export FULLSCREEN_NAME="ONLYOFFICE"
    bash $STARTUPDIR/fullscreen_window.sh &
elif [ "$MAXIMIZE" = "true" ]; then
    echo "Starting maximize script"
    export MAXIMIZE_NAME="ONLYOFFICE"
    bash $STARTUPDIR/maximize_window.sh &
fi 

# Try to set up the private (per user) User Data folder
set +e
mkdir -p $HOME/.config/onlyoffice
if [ -d $HOME/.config/onlyoffice ]; then
    if [ "$dark_mode" = "true" ]; then
        echo -e "[General]\nUITheme=theme-contrast-dark\n" > "$HOME/.config/onlyoffice/DesktopEditors.conf"
    fi
fi
set -e

DEFAULT_ARGS="--new:word"
ARGS=${APP_ARGS:-$DEFAULT_ARGS}
START_COMMAND="/usr/bin/desktopeditors --lock-portals"
echo "Starting OnlyOffice with command: $START_COMMAND $ARGS"
eval "$START_COMMAND $ARGS"

# Only do process monitoring if env variable is set
if [ -n "$MONITOR_PROCESS" ]; then
    echo "Entering process monitoring loop"
    PGREP="DesktopEditors"
    set +x
    while true
    do
        if ! pgrep -x $PGREP > /dev/null
        then
            echo "Application not found, terminating xfce4 session"
            xfce4-session-logout --logout --fast
            break
        fi
        sleep 0.5
    done
    set -x
fi
