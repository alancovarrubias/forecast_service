require 'rails_helper'

RSpec.describe 'Services::Forecast' do
  let(:address) { { zipcode: '93065' } }
  it 'fetches forecasts' do
    service = Services::Forecast.new({})
    expect(service.fetch_forecast).to eq({ 'completed' => false, 'id' => 1, 'title' => 'delectus aut autem', 'userId' => 1 })
  end

  it 'stores response within cache' do
    with_clean_caching do
      hits, misses = faraday_cache_counts do
        service = Services::Forecast.new({})
        service.fetch_forecast
        service.fetch_forecast
        service.fetch_forecast
      end
      expect(hits).to eq(2)
      expect(misses).to eq(1)
    end
  end
end
