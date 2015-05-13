package com.example.echo.providers.cassandra;

import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.example.echo.domain.EchoMessage;
import com.example.echo.providers.EchoMessageProvider;

import javax.inject.Inject;
import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.stream.StreamSupport;

public class CassandraEchoMessageProvider implements EchoMessageProvider {

    private Session session;

    @Inject
    public CassandraEchoMessageProvider(Session session) {
        this.session = session;
    }

    @Override
    public EchoMessage logMessage(EchoMessage message) {
        insertMessage(message);
        return message;
    }

    @Override
    public List<EchoMessage> getMessages() {
        return selectStream().map(createMappingFunction()).collect(Collectors.toList());
    }

    private Function<Row, EchoMessage> createMappingFunction() {
        return (row) -> {
            UUID id = row.getUUID("id");
            String msg = row.getString("message");
            Date timestamp = row.getDate("event_time");
            EchoMessage message = new EchoMessage(id, msg, timestamp);
            return message;
        };
    }

    private void insertMessage(EchoMessage message) {
        String insertCommand = buildInsert(message);
        session.execute(insertCommand);
    }

    private Stream<Row> selectStream() {
        ResultSet resultSet = selectMessages();
        return StreamSupport.stream(Spliterators.spliteratorUnknownSize(resultSet.iterator(),
            Spliterator.IMMUTABLE | Spliterator.NONNULL), false);
    }

    private ResultSet selectMessages() {
        return session.execute(buildSelect());
    }

    private String buildSelect() {
        return "SELECT * FROM example.event;";
    }

    private String buildInsert(EchoMessage message) {
       return "INSERT INTO example.event (id, message, event_time) VALUES (" +
           message.getID() + ", '" + message.getMessage() + "', '" +
           message.getTimestamp() + "');";
    }
}
