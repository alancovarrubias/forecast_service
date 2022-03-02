require 'rails_helper'

RSpec.describe 'Services::Forecast' do
  let(:address) { { zipcode: '93065' } }
  it 'fetches forecasts' do
    service = Services::Forecast.new({})
    expect(service.fetch_forecast).to eq({ 'completed' => false, 'id' => 1, 'title' => 'delectus aut autem', 'userId' => 1 })
  end

  it 'stores response within cache' do
    with_clean_caching do
      service = Services::Forecast.new({})
      service.fetch_forecast
      expect(Rails.cache.instance_variable_get(:@data).length).to eq(1)
    end
  end

  it 'no longer has cache' do
    expect(Rails.cache.instance_variable_get(:@data).length).to eq(0)
  end
end
