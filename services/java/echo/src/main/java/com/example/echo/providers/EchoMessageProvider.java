package com.example.echo.providers;

import com.example.echo.domain.EchoMessage;

import java.util.List;

public interface EchoMessageProvider {

    EchoMessage logMessage(EchoMessage message);
    List<EchoMessage> getMessages();

}
