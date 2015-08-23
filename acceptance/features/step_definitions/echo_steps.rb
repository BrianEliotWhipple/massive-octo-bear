
Given(/^An echo message of "([^"]*)" is sent to the echo service$/) do | message |
  @response = send_echo_message message
end

Then(/^A response message will echo the "([^"]*)" message$/) do | expected_message |
  validate_response_echoed_message @response, expected_message
end
