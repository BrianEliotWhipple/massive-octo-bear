package com.example.echo;

import dagger.Module;
import dagger.Provides;
import io.dropwizard.setup.Environment;

@Module
public class DropwizardEnvironmentModule {

    private EchoConfiguration configuration;
    private Environment environment;

    public void setConfiguration(EchoConfiguration config) {
        configuration = config;
    }

    public void setEnvironment(Environment env) {
        environment = env;
    }

    @Provides
    EchoConfiguration provideConfiguration() {
        return configuration;
    }

    @Provides
    Environment provideEnvironment() {
        return environment;
    }
}
