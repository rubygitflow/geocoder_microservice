# frozen_string_literal: true

require_relative 'application_contract'

class GeocoderParamsContract < ApplicationContract
  params do
    optional(:city).value(:string)
  end

  # https://dry-rb.org/gems/dry-validation/1.8/
  rule(:city) do
    if !key? || values[:city].blank?
      key.failure(I18n.t(:blank, scope: 'model.errors.geocoder.city',
                                 default: 'missing parameter'))
    end
  end
end
