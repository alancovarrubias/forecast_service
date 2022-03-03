require 'rails_helper'

RSpec.describe 'ForecastService' do
  let(:placeholder) { double(PlaceholderService) }
  let(:current_weather_data) { double(CurrentWeatherData) }
  let(:cache_double) { double(CacheData) }
  let(:service) { ForecastService.new({ 'zipcode' => '93065' }) }
  let(:current_temp) { 58.32 }
  it 'current methods get sent to current_weather_data' do
    allow(CurrentWeatherData).to receive(:new).and_return(current_weather_data)
    expect(current_weather_data).to receive(:current_temp)
    service.current_temp
  end

  it 'placeholder methods get sent to placeholder' do
    allow(PlaceholderService).to receive(:new).and_return(placeholder)
    expect(placeholder).to receive(:placeholder_todos)
    service.placeholder_todos
  end

  it 'cache methods get sent to cache_double' do
    allow(CacheData).to receive(:new).and_return(cache_double)
    expect(cache_double).to receive(:cache_hits).at_least(:once).and_return(1)
    service.cache_hits
  end

  it 'caching with query params fails' do
    with_clean_caching do
      service.current_temp
      service.current_temp
      service.current_temp
      expect(service.cache_hits).to eq(2)
    end
  end

  it 'caching with no query params' do
    with_clean_caching do
      service.placeholder_todos
      service.placeholder_todos
      service.placeholder_todos
      expect(service.cache_hits).to eq(2)
    end
  end
end
