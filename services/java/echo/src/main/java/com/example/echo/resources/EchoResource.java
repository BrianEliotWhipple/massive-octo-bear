package com.example.echo.resources;

import com.codahale.metrics.annotation.Timed;
import com.example.echo.domain.EchoMessage;
import com.example.echo.providers.EchoMessageProvider;
import com.google.common.base.Optional;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/echo")
@Produces(MediaType.APPLICATION_JSON)
public class EchoResource {

    private EchoMessageProvider echoMessageProvider;

    public EchoResource(EchoMessageProvider echoMessageProvider) {
        this.echoMessageProvider = echoMessageProvider;
    }

    @GET
    @Timed
    public EchoMessage echo(@QueryParam("msg") Optional<String> msg) {
        return echoMessageProvider.logMessage(new EchoMessage(msg));
    }

}
