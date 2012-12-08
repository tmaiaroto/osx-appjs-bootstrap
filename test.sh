#!/bin/sh

# First, kill the old process by looking for the node from this project and getting its PID.
get_proc=`ps -e -o pid,command | grep "${DIR}/bin/node"`
echo $get_proc > get_it
get_pid=`awk -F" " '{ print $1 }' get_it`
kill -9 $get_pid > /dev/null 2>&1;


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

${DIR}/bin/node --harmony ${DIR}/src/app;