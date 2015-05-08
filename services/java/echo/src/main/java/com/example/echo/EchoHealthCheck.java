package com.example.echo;

import com.codahale.metrics.health.HealthCheck;

public class EchoHealthCheck extends HealthCheck {

    @Override
    protected Result check() throws Exception {
        return Result.healthy();
    }
}
