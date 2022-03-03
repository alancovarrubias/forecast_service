require 'rails_helper'

RSpec.describe 'ForecastService' do
  let(:current_weather_data) { double(CurrentWeatherData) }
  let(:cache_data) { double(CacheData) }
  let(:service) { ForecastService.new({ 'zipcode' => '93065' }) }
  let(:current_temp) { 58.32 }
  it 'current methods get sent to current_weather_data' do
    allow(CurrentWeatherData).to receive(:new).and_return(current_weather_data)
    expect(current_weather_data).to receive(:current_temp)
    service.current_temp
  end
end
