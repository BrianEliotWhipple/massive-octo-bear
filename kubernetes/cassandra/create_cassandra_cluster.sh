#!/bin/sh

echo "Creating Cassandra cluster in Kubernetes..."

kubectl.sh create -f cassandra-service.yaml

# create a replication controller to replicate cassandra nodes
kubectl.sh create -f cassandra-controller.yaml

# scale up to 3 nodes
kubectl.sh scale rc cassandra --replicas=3

sleep 10s

echo "Done creating Cassandra cluster in Kubernetes..."
