
# Load application driver implementation code
libdir = File.join(File.dirname(__FILE__), '..', '..', 'lib')
$LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require 'rest_client'

# Application Driver implementation
require 'runtime_configuration'
require 'echo_service'
require 'admin_tasks'
