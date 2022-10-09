# frozen_string_literal: true

require 'spec_helper'

ENV['RACK_ENV'] ||= 'test'

require_relative '../config/environment'

abort('You run tests in production mode. Please don\'t do this!') if GeocoderMicroservice.environment == :production
Dir[GeocoderMicroservice.root.concat('/spec/support/**/*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RouteHelpers, type: :routes
end
