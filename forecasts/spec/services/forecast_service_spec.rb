require 'rails_helper'

RSpec.describe 'ForecastService' do
  let(:service) { ForecastService.new({ 'zipcode' => '93065' }) }
  let(:placeholder_body) { { 'completed' => false, 'id' => 1, 'title' => 'delectus aut autem', 'userId' => 1 } }
  it 'fetches forecasts first from api then from cache' do
    VCR.use_cassette('avatar_upload') do
      with_clean_caching do
        expect(service.fetch).to eq({ body: placeholder_body, cached: false })
        expect(service.fetch).to eq({ body: placeholder_body, cached: true })
      end
    end
  end

  it 'stores response within cache' do
    with_clean_caching do
      service.fetch
      service.fetch
      service.fetch
      expect(service.cache_hits).to eq(2)
      expect(service.cache_misses).to eq(1)
    end
  end
end
