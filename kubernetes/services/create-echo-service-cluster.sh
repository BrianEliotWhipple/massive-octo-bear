#!/bin/sh

kubectl.sh create -f echo-service-service.yaml

# create a replication controller to replicate Echo service nodes
kubectl.sh create -f echo-service-controller.yaml

# scale up to 1 nodes
kubectl.sh scale rc echo-service --replicas=1
