package com.example.echo;

import com.example.echo.providers.SchemaBuilder;
import com.example.echo.resources.LogResource;
import com.example.echo.tasks.CleanSchemaTask;
import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
import io.dropwizard.configuration.EnvironmentVariableSubstitutor;
import io.dropwizard.configuration.SubstitutingSourceProvider;
import com.example.echo.resources.EchoResource;

public class EchoApplication extends Application<EchoConfiguration> {


    public static void main(String[] args) throws Exception {
        new EchoApplication().run(args);
    }

    @Override
    public String getName() {
        return "EchoService";
    }

    @Override
    public void initialize(Bootstrap<EchoConfiguration> bootstrap) {
        // Enable variable substitution with environment variables
        bootstrap.setConfigurationSourceProvider(
                new SubstitutingSourceProvider(bootstrap.getConfigurationSourceProvider(),
                        new EnvironmentVariableSubstitutor()
                )
        );
    }

    @Override
    public void run(EchoConfiguration configuration,
                    Environment environment) {
        EchoComponent echoComponent = EchoComponent.createEchoComponent(environment,
            configuration);
        createSchema(echoComponent.getSchemaBuilder());
        registerResources(environment, echoComponent);
        registerTasks(environment, echoComponent);
        registerHealthChecks(environment);
    }

    private void createSchema(SchemaBuilder schemaBuilder) {
        schemaBuilder.createSchema();
    }

    private void registerResources(Environment environment, EchoComponent echoComponent) {
        EchoResource echoResource = new EchoResource(echoComponent.getEchoMessageProvider());
        environment.jersey().register(echoResource);
        LogResource logResource = new LogResource(echoComponent.getEchoMessageProvider());
        environment.jersey().register(logResource);
    }

    private void registerHealthChecks(Environment environment) {
        final EchoHealthCheck healthCheck = new EchoHealthCheck();
        environment.healthChecks().register("available", healthCheck);
    }

    private void registerTasks(Environment environment, EchoComponent echoComponent) {
        CleanSchemaTask cleanSchemaTask = new CleanSchemaTask(echoComponent.getSchemaCleaner());
        environment.admin().addTask(cleanSchemaTask);
    }
}
