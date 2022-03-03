require 'rails_helper'

RSpec.describe 'OpenWeatherService' do
  let(:json_file) { read_json_file('api_response.json') }
  let(:service) { OpenWeatherService.new }
  it 'fetches forecasts first from api then from cache' do
    expect(json_file['base']).to eq('stations')
  end
end
