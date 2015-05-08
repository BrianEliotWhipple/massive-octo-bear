package com.example.echo;

import io.dropwizard.Application;
import io.dropwizard.setup.Bootstrap;
import io.dropwizard.setup.Environment;
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
        // nothing to do yet
    }

    @Override
    public void run(EchoConfiguration configuration,
                    Environment environment) {
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
