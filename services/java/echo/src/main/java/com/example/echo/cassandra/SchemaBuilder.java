package com.example.echo.cassandra;

import com.datastax.driver.core.Session;

import javax.inject.Inject;

public class SchemaBuilder {

    private Session session;

    @Inject
    public SchemaBuilder(Session session) {
        this.session = session;
    }

    public void createSchema() {
        session.execute("CREATE KEYSPACE IF NOT EXISTS example WITH replication " +
                "= {'class':'SimpleStrategy', 'replication_factor':3};");

        session.execute("CREATE TABLE IF NOT EXISTS example.event (" +
                "  id uuid PRIMARY KEY," +
                "  message text," +
                "  event_time timestamp" +
                "  );");
    }
}
