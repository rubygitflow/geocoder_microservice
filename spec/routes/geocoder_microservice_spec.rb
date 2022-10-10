# frozen_string_literal: true

RSpec.describe GeocoderMicroservice, type: :routes do
  describe 'GET /' do
    subject { described_class }
  
    context 'with existed city' do
      it 'should return Moscow coordinates' do
        get '/', city: 'Москва'

        expect(response_body['data']).to a_hash_including(
          "lat"=>55.7540471,
          "lon"=>37.620405
        )
      end
    end

    context 'with nonexistent city' do
      it 'should what' do
        get '/', city: 'Таллинн'
        
        expect(response_body['data']).to a_hash_including(
          "errors"=>"The requested resource is not found"
        )
      end
    end
  end
end
