package com.example.echo.tasks;

import com.google.common.collect.ImmutableMultimap;
import io.dropwizard.servlets.tasks.Task;
import com.example.echo.providers.SchemaCleaner;

import java.io.PrintWriter;

/**
 * Created by whipple on 8/23/15.
 */
public class CleanSchemaTask extends Task {

    private final SchemaCleaner schemaCleaner;

    public CleanSchemaTask(SchemaCleaner cleaner) {
        super("clean-schema");
        schemaCleaner = cleaner;
    }
    @Override
    public void execute(ImmutableMultimap<String, String> parameters, PrintWriter output) throws Exception {
        schemaCleaner.clean();
    }
}
