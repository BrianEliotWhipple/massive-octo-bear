
require 'rest_client'
require 'runtime_configuration'

def clear_logs
  RestClient.post "#{RuntimeConfiguration.echo_service_admin_url}/tasks/clean-schema"
end
