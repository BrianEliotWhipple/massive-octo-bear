#!/bin/sh

curl -X POST -H "Content-Type: application/json" --data @cassandra_application.json http://192.168.12.100:8080/v2/apps

curl -X POST -H "Content-Type: application/json" --data @echo_application.json http://192.168.12.100:8080/v2/apps
