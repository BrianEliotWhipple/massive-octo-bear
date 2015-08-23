package com.example.echo;

import com.example.echo.providers.EchoMessageProvider;
import com.example.echo.providers.SchemaCleaner;
import com.example.echo.providers.SchemaBuilder;
import com.example.echo.providers.cassandra.CassandraModule;
import dagger.Component;
import io.dropwizard.setup.Environment;

import javax.inject.Singleton;

@Singleton
@Component(modules = { DropwizardEnvironmentModule.class, CassandraModule.class })
public interface EchoComponent {

    SchemaBuilder getSchemaBuilder();
    SchemaCleaner getSchemaCleaner();
    EchoMessageProvider getEchoMessageProvider();

    public static EchoComponent createEchoComponent(Environment env, EchoConfiguration config) {
        DropwizardEnvironmentModule dropwizardEnvironmentModule = new DropwizardEnvironmentModule();
        dropwizardEnvironmentModule.setConfiguration(config);
        dropwizardEnvironmentModule.setEnvironment(env);
        return DaggerEchoComponent.builder()
           .dropwizardEnvironmentModule(dropwizardEnvironmentModule)
           .build();
    }
}
