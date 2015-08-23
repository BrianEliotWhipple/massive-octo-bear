
require 'json'
require 'rest_client'
require 'runtime_configuration'

def send_echo_message(message)
  response = RestClient.get "#{RuntimeConfiguration.echo_service_url}/echo", { :params => { :msg => message } }
  JSON.parse(response.body.to_s)
end

def validate_response_echoed_message(response, expected_message)
  expect(response['message']).to eql(expected_message)
end

def request_and_validate_echo_logs(expected_messages)
  response = request_echo_logs
  validate_echo_logs response, expected_messages
end
def request_echo_logs
  response = RestClient.get "#{RuntimeConfiguration.echo_service_url}/log"
  JSON.parse(response.body.to_s)
end

def validate_echo_logs(actual_response, expected_messages)
  puts actual_response
  puts expected_messages
end
