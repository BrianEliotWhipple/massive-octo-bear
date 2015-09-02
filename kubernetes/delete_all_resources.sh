#!/bin/sh

kubectl.sh delete pods,services,replicationcontrollers -l name=cassandra
kubectl.sh delete pods,services,replicationcontrollers -l name=echo-service
