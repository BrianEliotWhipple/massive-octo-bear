#!/bin/sh

marathon_host="172.17.8.11"
echo "Creating apps on marathon host: ${marathon_host}"

curl -X DELETE http://${marathon_host}:8080/v2/groups/example

curl -X POST -H "Content-Type: application/json" --data @example_app_group.json http://${marathon_host}:8080/v2/groups
