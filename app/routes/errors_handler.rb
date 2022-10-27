# frozen_string_literal: true

class GeocoderMicroservice
  include ApiErrors

  # https://roda.jeremyevans.net/rdoc/classes/Roda/RodaPlugins/ErrorHandler.html
  plugin :error_handler do |e|
    case e
    when Roda::RodaPlugins::TypecastParams::Error
      response.status = 422
      error_response e.message, meta: { 'meta' => I18n.t(:missing_parameters, scope: 'api.errors') }
    when KeyError
      response.status = 422
      error_response e.message, meta: { 'meta' => I18n.t(:missing_parameters, scope: 'api.errors') }
    when MissingParams # Dry::Validation::Result
      response.status = 422
      error_response(e.errors)
    else
      response.status = 500
      puts "[#{Time.now}] #{e.inspect}\n#{e.backtrace&.join("\n")}"
      error_response e.message, meta: { 'meta' => e.class }
    end
  end
end
