

Given(/^A request for all the echo message logs is made$/) do
  @response = request_echo_logs
end

Then(/^A response message will return all the logged echo messages\.$/) do
  validate_echo_logs @response
end
