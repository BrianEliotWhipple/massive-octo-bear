package com.example.echo.resources;

import com.codahale.metrics.annotation.Timed;
import com.example.echo.domain.EchoMessage;
import com.example.echo.providers.EchoMessageProvider;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import java.util.List;

@Path("/log")
@Produces(MediaType.APPLICATION_JSON)
public class LogResource {

    private EchoMessageProvider echoMessageProvider;

    public LogResource(EchoMessageProvider echoMessageProvider) {
        this.echoMessageProvider = echoMessageProvider;
    }

    @GET
    @Timed
    public List<EchoMessage> log() {
        return echoMessageProvider.getMessages();
    }
}
