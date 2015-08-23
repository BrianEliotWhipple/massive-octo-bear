
@log
Feature: Query all the logged echo messages.

  Client can request a log of all echo messages processed by the echo service.

  Scenario:  Requesting the echo message logs returns a request will all logged echo messages.
    Given A request for all the echo message logs is made
    Then A response message will return all the logged echo messages.

