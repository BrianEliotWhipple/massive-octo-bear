
module RuntimeConfiguration

  def self.echo_service_url
    ENV['ECHO_SERVICE_URL']
  end

  def self.echo_service_admin_url
    ENV['ECHO_SERVICE_ADMIN_URL']
  end

end