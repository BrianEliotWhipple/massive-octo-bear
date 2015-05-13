package com.example.echo.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.UUID;

import com.google.common.base.Optional;

public final class EchoMessage {

    private final UUID id;
    private final String timestamp;
    private final String message;

    public EchoMessage(final Optional<String> optionalMessage) {
        this.id = UUID.randomUUID();
        this.message = optionalMessage.or("No echo message provided.");
        this.timestamp = LocalDateTime.now(ZoneId.of("UTC"))
             .format(DateTimeFormatter.ISO_DATE_TIME);
    }

    public EchoMessage(final UUID id, final String message, final Date timestamp) {
        this.id = id;
        this.message = Optional.of(message).or("No echo message provided.");
        this.timestamp = convertDateToString(timestamp);
    }

    @JsonProperty
    public String getID() { return id.toString();}

    @JsonProperty
    public String getTimestamp() {
        return timestamp;
    }

    @JsonProperty
    public String getMessage() { return message; }

    private String convertDateToString(Date date) {
        Instant instant = Instant.ofEpochMilli(date.getTime());
        return LocalDateTime.ofInstant(instant, ZoneId.of("UTC"))
           .format(DateTimeFormatter.ISO_DATE_TIME);
    }
}
