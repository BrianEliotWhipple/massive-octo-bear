
require 'rest_client'
require 'runtime_configuration'

def clear_logs
  RestClient::Request.execute(
      :url => "#{RuntimeConfiguration.echo_service_admin_url}/tasks/clean-schema",
      :method => :POST)
end
