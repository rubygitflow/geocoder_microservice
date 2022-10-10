# frozen_string_literal: true

require 'csv'

module Geocoder
  class SearchService
    extend Dry::Initializer[undefined: false]
    
    DATA_PATH = 'db/data/city.csv'

    param :city

    attr_reader :city

    def initialize(city:)
      @city = city
    end

    def self.call(city)
      geocoder = new(city: city)
      geocoder.data[city]
    end

    def data
      @data ||= load_data!
    end

    private

    def load_data!
      path = File.join(root, DATA_PATH)

      @data = CSV.read(path, headers: true).inject({}) do |result, row|
        city = row['city']
        lat = row['geo_lat'].to_f
        lon = row['geo_lon'].to_f
        result[city] = [lat, lon]
        result
      end
    end

    def root
      File.expand_path('../../../', __dir__)
    end
  end
end
