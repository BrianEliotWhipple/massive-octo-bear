#!/bin/sh

if [ "$1" != "" ]; then
    marathon_host="$1"
    echo "Creating apps on marathon host: ${marathon_host}"
else
    echo "Marathon hostname or ip address is required."
    exit 1
fi

curl -X DELETE http://${marathon_host}:8080/v2/groups/example

curl -X POST -H "Content-Type: application/json" --data @example_app_group.json http://${marathon_host}:8080/v2/groups
