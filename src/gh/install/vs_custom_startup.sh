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
    export FULLSCREEN_NAME="VarSeq"
    bash $STARTUPDIR/fullscreen_window.sh &
elif [ "$MAXIMIZE" = "true" ]; then
    echo "Starting maximize script"
    export MAXIMIZE_NAME="VarSeq"
    bash $STARTUPDIR/maximize_window.sh &
fi 


# Try to set up the private (per user) User Data folder
set +e
mkdir -p $HOME/Workspace/Documents/$USERNAME/VarSeqUserData
if [ -d $HOME/Workspace/Documents/$USERNAME/VarSeqUserData ]; then
 mkdir -p "$HOME/.local/share/Golden Helix/VarSeq/"
 ln -s $HOME/Workspace/Documents/$USERNAME/VarSeqUserData "$HOME/.local/share/Golden Helix/VarSeq/User Data"
fi
set -e

# If the SERVER environment variable is set, create a hosts.json file to
# have VarSeq log into the VSW server for authentication
if [ ! -z "$SERVER" ] && [ ! -z "$USE_SERVER_AUTH" ]; then
   cat > /opt/VarSeq/hosts.json << 'EOF'
{
   "update": "https://${SERVER}/auth/api/update/"
}
EOF
fi

DEFAULT_ARGS=""
ARGS=${APP_ARGS:-$DEFAULT_ARGS}
START_COMMAND="/opt/VarSeq/VarSeq"
echo "Starting VarSeq with command: $START_COMMAND $ARGS"
eval "$START_COMMAND $ARGS"

# Only do process monitoring if env variable is set
if [ -n "$MONITOR_PROCESS" ]; then
    echo "Entering process monitoring loop"
    PGREP="VarSeq.bin"
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
