package com.example.echo;

import com.example.echo.cassandra.CassandraConfig;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.dropwizard.Configuration;

import javax.validation.Valid;
import javax.validation.constraints.NotNull;

public class EchoConfiguration extends Configuration {

    @Valid
    @NotNull
    private CassandraConfig cassandraConfig = new CassandraConfig();

    @JsonProperty("cassandra")
    public CassandraConfig getCassandraConfig() {
        return cassandraConfig;
    }

    @JsonProperty("cassandra")
    public void setCassandraConfig(CassandraConfig cassandraConfig) {
        this.cassandraConfig = cassandraConfig;
    }
}
