package com.example.echo.providers.cassandra;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Session;
import com.example.echo.EchoConfiguration;
import com.example.echo.providers.EchoMessageProvider;
import com.example.echo.providers.SchemaBuilder;
import com.example.echo.providers.SchemaCleaner;
import dagger.Module;
import dagger.Provides;
import io.dropwizard.lifecycle.Managed;
import io.dropwizard.setup.Environment;

@Module
public class CassandraModule {

    @Provides
    public SchemaBuilder providesSchemaBuilder(Session session) {
        return new CassandraSchemaBuilder(session);
    }

    @Provides
    public SchemaCleaner providesSchemaCleaner(Session session) {
        return new CassandraSchemaCleaner(session);
    }

    @Provides
    public EchoMessageProvider providesEchoMessageProvider(Session session) {
        return new CassandraEchoMessageProvider(session);
    }

    @Provides
    public Session providesSession(Environment environment, EchoConfiguration config) {
        final Cluster cluster = Cluster.builder()
                .addContactPoints(config.getCassandraConfig().getSeedHost())
                .withPort(config.getCassandraConfig().getSeedCqlPort()).build();
        Metadata clusterMetadata = cluster.getMetadata();
        System.out.printf("Connected to cluster: %s\n",
                clusterMetadata.getClusterName());
        for ( Host host : clusterMetadata.getAllHosts() ) {
            System.out.printf("Datacenter: %s; Host: %s; Rack: %s\n",
                    host.getDatacenter(), host.getAddress(), host.getRack());
        }

        final Session session = cluster.connect();

        environment.lifecycle().manage(new Managed() {
            @Override
            public void start() {
            }

            @Override
            public void stop() {
                session.close();
                cluster.close();
            }
        });
        return session;
    }

}
