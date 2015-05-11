package com.example.echo.cassandra;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

/**
 * Created by whipple on 5/11/2015.
 */
public class CassandraConfig {

    @NotEmpty
    private String seedHost;

    @Min(1)
    @Max(65535)
    private int seedCqlPort = 9042;

    @JsonProperty
    public String getSeedHost() {
        return seedHost;
    }

    @JsonProperty
    public void setSeedHost(String seedHost) {
        this.seedHost = seedHost;
    }

    @JsonProperty
    public int getSeedCqlPort() {
        return seedCqlPort;
    }

    @JsonProperty
    public void setSeedCqlPort(int port) {
        this.seedCqlPort = port;
    }

}
