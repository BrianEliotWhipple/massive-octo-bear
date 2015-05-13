package com.example.echo.providers.cassandra;

import com.datastax.driver.core.Session;
import com.example.echo.providers.SchemaBuilder;

import javax.inject.Inject;

public class CassandraSchemaBuilder implements SchemaBuilder {

    private final Session session;

    @Inject
    public CassandraSchemaBuilder(Session session) {
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
