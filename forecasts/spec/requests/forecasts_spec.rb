require 'rails_helper'

RSpec.describe 'Forecast', type: :request do
  let(:address) { { zipcode: '93065' } }
  describe 'POST /forecasts' do
    it 'responds successfully' do
      post forecasts_path, params: { address: address }
      expect(response).to have_http_status(200)
    end

    it 'returns address in response' do
      post forecasts_path, params: { address: address }
      expect(response.parsed_body['address']).to eq({ 'zipcode' => '93065' })
    end

    describe 'forecast fetching' do
      let(:forecast_double) { instance_double(Weather::Forecast) }
      let(:forecast) { {} }
      it 'returns forecast from external weather api' do
        expect(Weather::Forecast).to receive(:new).with(address).and_return(forecast_double)
        expect(forecast_double).to receive(:fetch).and_return(forecast)
        post forecasts_path, params: { address: address }
        expect(response.parsed_body['forecast']).to eq(forecast)
      end
    end
  end
end
