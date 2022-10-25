# frozen_string_literal: true

class Application
  def self.root
    ApplicationLoader.root
  end

  def self.environment
    ENV.fetch('RACK_ENV').to_sym
  end
end
