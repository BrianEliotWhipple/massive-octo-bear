package com.example.echo;

import com.datastax.driver.core.Session;
import com.example.echo.cassandra.SchemaBuilder;
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
        EchoService.init(environment, configuration);
        registerResources(environment);
        registerHealthChecks(environment);
    }

    private void registerResources(Environment environment) {
        final EchoResource resource = new EchoResource();
        environment.jersey().register(resource);
    }

    private void registerHealthChecks(Environment environment) {
        final EchoHealthCheck healthCheck = new EchoHealthCheck();
        environment.healthChecks().register("available", healthCheck);
    }

}
