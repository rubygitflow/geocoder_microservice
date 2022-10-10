# frozen_string_literal: true

require 'dry/validation'

class GeocoderParamsContract < Dry::Validation::Contract
  params do
    required(:city).filled(:string)
  end
end
