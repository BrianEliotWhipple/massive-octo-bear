#!/bin/sh

marathon_host="10.245.1.101"

echo "Creating cassandra application on marathon host: ${marathon_host}"
curl -X POST -H "Content-Type: application/json" --data @cassandra_application.json http://${marathon_host}:8080/v2/apps

echo "Creating echo service application on marathon host: ${marathon_host}"
curl -X POST -H "Content-Type: application/json" --data @echo_application.json http://${marathon_host}:8080/v2/apps
