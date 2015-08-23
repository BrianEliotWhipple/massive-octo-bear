
Then(/^Requesting the echo logs will return the logged messages:$/) do | table |
  request_and_validate_echo_logs table
end
