package com.example.echo.resources;

import com.example.echo.domain.EchoMessage;

import com.google.common.base.Optional;
import com.codahale.metrics.annotation.Timed;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

@Path("/echo")
@Produces(MediaType.APPLICATION_JSON)
public class EchoResource {

    @GET
    @Timed
    public EchoMessage echo(@QueryParam("msg") Optional<String> msg) {
        return new EchoMessage(msg);
    }
}
