package com.example.echo;

import com.example.echo.cassandra.CassandraModule;
import com.example.echo.cassandra.SchemaBuilder;
import dagger.Component;
import io.dropwizard.setup.Environment;

import javax.inject.Inject;

/**
 * Created by whipple on 5/11/2015.
 */

public class EchoService {

    private SchemaBuilder schemaBuilder;

    @Component(modules = { DropwizardEnvironmentModule.class, CassandraModule.class })
    public interface EchoServiceMaker {
        EchoService maker();
    }

    public static void init(Environment env, EchoConfiguration config) {
        DropwizardEnvironmentModule dropwizardEnvironmentModule = new DropwizardEnvironmentModule();
        dropwizardEnvironmentModule.setConfiguration(config);
        dropwizardEnvironmentModule.setEnvironment(env);
        EchoServiceMaker echoServiceMaker = DaggerEchoService_EchoServiceMaker.builder()
                .dropwizardEnvironmentModule(dropwizardEnvironmentModule)
                .cassandraModule(new CassandraModule(env, config.getCassandraConfig()))
                .build();
        echoServiceMaker.maker().initService();
    }

    @Inject
    public EchoService(SchemaBuilder schemaBuilder) {
        this.schemaBuilder = schemaBuilder;
    }

    public void initService() {
        schemaBuilder.createSchema();
    }
}
