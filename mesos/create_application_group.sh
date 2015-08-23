#!/bin/sh

marathon_host="172.17.8.10"

echo "Deleting example application group on marathon host: ${marathon_host}"
curl -X DELETE http://${marathon_host}:8080/v2/groups/example

echo "Sleeping 30s..."
sleep 30s

echo "Creating example application group on marathon host: ${marathon_host}"
curl -X POST -H "Content-Type: application/json" --data @example_app_group.json http://${marathon_host}:8080/v2/groups
