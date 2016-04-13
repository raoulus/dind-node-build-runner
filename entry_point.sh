#!/bin/bash
export GEOMETRY="$SCREEN_WIDTH""x""$SCREEN_HEIGHT""x""$SCREEN_DEPTH"

function shutdown {
  kill -s SIGTERM $NODE_PID
  wait $NODE_PID
}

if [ ! -z "$SE_OPTS" ]; then
  echo "appending selenium options: ${SE_OPTS}"
fi

xvfb-run --server-args="$DISPLAY -screen 0 $GEOMETRY -ac +extension RANDR" selenium-standalone start &
NODE_PID=$!

trap shutdown SIGTERM SIGINT

if [[ $# -gt 0 ]] ; then
  eval "$*"
fi

wait $NODE_PID
