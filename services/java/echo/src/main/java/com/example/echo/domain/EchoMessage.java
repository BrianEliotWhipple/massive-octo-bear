package com.example.echo.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import com.google.common.base.Optional;

public final class EchoMessage {

    private final String timestamp;
    private final String message;

    public EchoMessage(final Optional<String> optionalMessage) {
        message = optionalMessage.or("No echo message provided.");
        timestamp = LocalDateTime.now(ZoneId.of("UTC")).format(DateTimeFormatter.ISO_DATE_TIME);
    }

    @JsonProperty
    public String getTimestamp() {
        return timestamp;
    }

    @JsonProperty
    public String getMessage() {
        return message;
    }
}
