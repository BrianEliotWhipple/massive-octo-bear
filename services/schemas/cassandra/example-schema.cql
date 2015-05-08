-- TODO switch to NetworkTopologyStrategy
CREATE KEYSPACE example
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE example;

CREATE TABLE event (
  message text,
  event_time timestamp
  );

