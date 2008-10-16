# main spec helper
require File.dirname(__FILE__) + '/../../../spec/spec_helper.rb'

# load spec helpers from all engines
engines_dir = File.dirname(__FILE__) + '/engines'
Dir[engines_dir + '/*/spec/spec_helper.rb'].each { |spec_helper_file| require spec_helper_file }

# load global spec helpers
spec_helpers_dir = File.dirname(__FILE__) + '/spec_helpers'
Dir[spec_helpers_dir + '/*.rb'].sort.each do |spec_helper_file|
  require spec_helper_file
end

# load all custom matchers
matchers_dir = File.dirname(__FILE__) + '/matchers'
Dir[matchers_dir + '/*.rb'].each do |matcher_file|
  require matcher_file
end

# load stubs and scenarios
Stubby::Definition.directory = File.dirname(__FILE__) + "/stubs"
Stubby::Scenario.directory = File.dirname(__FILE__) + "/scenarios"

Stubby.load

# load extensions
require "cacheable_flash/test_helpers"
require "rspec_on_rails_on_crack"
# AGW::CacheTest.setup
ActionController::TestResponse.send(:include, CacheableFlash::TestHelpers)

# set locale
I18n.default_locale = :en # set this up globally as it will be setup in base controllers
RoutingFilter::Locale.default_locale = I18n.default_locale

Spec::Rails::Example::ControllerExampleGroup.class_eval do
  def params_from(method, path, env = {:host_with_port => 'test.host'})
    ensure_that_routes_are_loaded
    env.merge!({:method => method})
    ActionController::Routing::Routes.recognize_path(path, env)
  end
end

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = File.dirname(__FILE__) + '/fixtures/'
end