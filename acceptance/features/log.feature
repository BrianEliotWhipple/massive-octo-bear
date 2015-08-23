
@log
Feature: Query all the logged echo messages.

  Client can request a log of all echo messages processed by the echo service.

  Background:
    Given The Echo Service has not logged any messages.

  Scenario:  Requesting the echo message logs returns a request will all logged echo messages.
    Given An echo message of "Hello World" is sent to the echo service
    And An echo message of "Goodbye World" is sent to the echo service
    And An echo message of "Ciao World" is sent to the echo service
    Then Requesting the echo logs will return the logged messages:
      | Hello World   |
      | Goodbye World |
      | Ciao World    |
