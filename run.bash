#!/usr/bin/env bash

# stop application and exit
function stop() {
    docker compose down
    exit 0
}

# go to repo root
cd $(git rev-parse --show-toplevel)

# if arg is stop, stop application and exit
[ "$1" == "stop" ] && stop

# build and run docker compose
if ! docker compose up --build --wait; then
	echo
    echo "Failed to start application! Exiting..."
    exit 1
fi

# set SIGINT handler
trap 'stop' SIGINT

# if arg is nowait, exit
[ "$1" == "nowait" ] && exit 0

# wait for input
echo
echo "Application is running!"
echo "Press enter, Ctrl+D or Ctrl+C to stop it."
read

# stop application
stop
