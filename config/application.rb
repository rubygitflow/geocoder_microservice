# frozen_string_literal: true

require 'json'

class GeocoderMicroservice < Roda
  # https://github.com/jeremyevans/rack-unreloader#classes-split-into-multiple-files-
  Unreloader.require 'app/helpers'
  Unreloader.require 'app/serializers'

  include Validations

  def self.root
    ApplicationLoader.root
  end

  # https://roda.jeremyevans.net/documentation.html
  plugin :environments
  # plugin :hash_routes
  plugin :typecast_params
  plugin :json

  plugin :default_headers,
         # 'Strict-Transport-Security'=>'max-age=16070400;', # Uncomment if only allowing https:// access
         'Content-Type' => 'application/json'

  plugin :not_found do
    {}
  end

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/ErrorHandler.html
  plugin :error_handler do |_e|
    request.redirect '../app/routes/errors_handler.rb'
  end

  # use Rack::Session::Cookie, secret: 'some_nice_long_random_string_DSKJH4378EYR7EGKUFH', key: '_roda_app_session'
  plugin :sessions,
         key: '_GeocoderMicroservice.session',
         # cookie_options: {secure: ENV['RACK_ENV'] != 'test'}, # Uncomment if only allowing https:// access
         secret: ENV.send((ENV['RACK_ENV'] == 'development' ? :[] : :delete), 'GEOCODER_MICROSERVICE_SESSION_SECRET')

  Unreloader.require('app/routes', delete_hook: proc { |f| hash_branch(File.basename(f).delete_suffix('.rb')) }) {}

  route do |r|
    r.root do
      geocoder_params = validate_with!(GeocoderParamsContract)
      result = Geocoder::SearchService.call(*geocoder_params.to_h.values)

      if result.present?
        response.status = 200
        { data: {
          lat: result[0],
          lon: result[1]
        } }
      else
        response.status = 422
        { data: {
          errors: I18n.t(:not_found, scope: 'api.errors')
        } }
      end
    end
  end
end
