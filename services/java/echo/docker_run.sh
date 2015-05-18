#!/bin/sh

sudo docker run -d --name example-java-echo -p 8080:8080 -p 8081:8081 --link cassandra-1:cassandra \
      -e CASSANDRA_SEED_HOST=cassandra  example/java-echo:0.1
