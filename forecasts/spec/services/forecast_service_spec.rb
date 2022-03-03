require 'rails_helper'

RSpec.describe 'ForecastService' do
  let(:service) { ForecastService.new({ 'zipcode' => '93065' }) }
  let(:current_temp) { 58.32 }
  it 'fetches forecasts first from api then from cache' do
    with_clean_caching do
      VCR.use_cassette('current_temp') do
        expect(service.current_temp).to eq(current_temp)
      end
    end
  end

  it 'stores response within cache' do
    with_clean_caching do
      service.current_temp
      service.current_temp
      service.current_temp
      expect(cache_data).to eq(2)
    end
  end
end
