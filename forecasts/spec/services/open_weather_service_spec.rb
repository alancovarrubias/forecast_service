require 'rails_helper'

RSpec.describe 'OpenWeatherService' do
  let(:base_url) { 'http://api.openweathermap.org' }
  let(:json_file) { read_json_file('api_response.json') }
  let(:service) { OpenWeatherService.new }
  let(:forecast_double) { instance_double(CachedRequestService) }
  let(:forecast) { { 'temperature' => 'hot' } }
  it 'fetches forecasts first from api then from cache' do
    expect(CachedRequestService).to receive(:new).with(base_url).and_return(forecast_double)
    expect(forecast_double).to receive(:get).and_return(json_file)
    expect(service.current_temp_zipcode('93065')).to eq(json_file['main']['temp'])
  end
end
