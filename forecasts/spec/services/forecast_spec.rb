require 'rails_helper'

RSpec.describe 'Services::Forecast' do
  let(:address) { { zipcode: '93065' } }
  it 'fetches forecasts' do
    service = Services::Forecast.new({})
    expect(service.fetch_forecast).to eq({ 'completed' => false, 'id' => 1, 'title' => 'delectus aut autem', 'userId' => 1 })
  end
end
