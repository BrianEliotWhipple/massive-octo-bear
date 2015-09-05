#!/bin/sh

echo "Deleting all resources in Kubernetes..."

kubectl.sh delete pods,services,replicationcontrollers -l name=cassandra
kubectl.sh delete pods,services,replicationcontrollers -l name=echo-service

sleep 10s

echo "Done deleting all resources in Kubernetes..."
