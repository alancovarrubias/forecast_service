require 'rails_helper'

RSpec.describe 'OpenWeatherService' do
  let(:base_url) { 'http://api.openweathermap.org' }
  let(:json_file) { read_json_file('api_response.json') }
  let(:request_double) { instance_double(CachedRequestService) }
  it 'fetches forecasts first from api then from cache' do
    expect(CachedRequestService).to receive(:new).with(base_url).and_return(request_double)
    expect(request_double).to receive(:get).and_return(json_file)
    OpenWeatherService.current_weather_by_zipcode('93065')
  end
end
