#!/bin/sh

marathon_host="172.17.8.11"
echo "Creating apps on marathon host: ${marathon_host}"

curl -X POST -H "Content-Type: application/json" --data @cassandra_application.json http://${marathon_host}:8080/v2/apps

curl -X POST -H "Content-Type: application/json" --data @echo_application.json http://${marathon_host}:8080/v2/apps