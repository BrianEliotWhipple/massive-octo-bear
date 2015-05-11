package com.example.echo.cassandra;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Host;
import com.datastax.driver.core.Metadata;
import com.datastax.driver.core.Session;
import dagger.Module;
import dagger.Provides;
import io.dropwizard.lifecycle.Managed;
import io.dropwizard.setup.Environment;

import javax.inject.Inject;

@Module
public class CassandraModule {

    private Environment environment;
    private CassandraConfig cassandraConfig;

    @Inject
    public CassandraModule(Environment env, CassandraConfig config) {
        this.environment = env;
        this.cassandraConfig = config;
    }

    @Provides
    public Session providesSession() {
        final Cluster cluster = Cluster.builder().addContactPoints(cassandraConfig.getSeedHost())
                .withPort(cassandraConfig.getSeedCqlPort()).build();
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
