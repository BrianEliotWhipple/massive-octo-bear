
@echo
Feature: Echo REST request messages

  Client invocation of the Echo Service will receive an echo response message.

  Background:
    Given The Echo Service has not logged any messages.

  Scenario:  Sending a Hello World echo request will receive a Hello World response.
    Given An echo message of "Hello World" is sent to the echo service
    Then A response message will echo the "Hello World" message
