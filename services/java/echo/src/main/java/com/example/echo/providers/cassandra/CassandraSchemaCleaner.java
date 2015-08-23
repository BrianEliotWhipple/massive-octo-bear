package com.example.echo.providers.cassandra;

import com.datastax.driver.core.Session;
import com.example.echo.providers.SchemaCleaner;

import javax.inject.Inject;

public class CassandraSchemaCleaner implements SchemaCleaner {

    private final Session session;

    @Inject
    public CassandraSchemaCleaner(Session session) {
        this.session = session;
    }

    public void clean() {
        session.execute("TRUNCATE example.event;");
    }
}
