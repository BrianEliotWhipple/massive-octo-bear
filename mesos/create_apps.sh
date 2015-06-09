#!/bin/sh

if [ "$1" != "" ]; then
    marathon_host="$1"
    echo "Creating apps on marathon host: ${marathon_host}"
else
    echo "Marathon hostname or ip address is required."
    exit 1
fi


curl -X POST -H "Content-Type: application/json" --data @cassandra_application.json http://${marathon_host}:8080/v2/apps

curl -X POST -H "Content-Type: application/json" --data @echo_application.json http://${marathon_host}:8080/v2/apps
