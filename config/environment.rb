# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

begin
  require_relative '../.env'
rescue LoadError
  # do nothing
end

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require_relative 'application_loader'
ApplicationLoader.load_app!
