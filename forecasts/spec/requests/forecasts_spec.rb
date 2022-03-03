require 'rails_helper'

RSpec.describe 'Forecast', type: :request do
  let(:address) { { zipcode: '93065' } }
  describe 'POST /forecasts' do
    it 'responds successfully' do
      VCR.use_cassette('current_temp') do
        post forecasts_path, params: { address: address }
        expect(response).to have_http_status(200)
      end
    end

    describe 'forecast fetching' do
      let(:forecast_service) { double(ForecastService) }
      let(:current_temp) { 59.9 }
      it 'returns forecast from external weather api' do
        expect(ForecastService).to receive(:new).with(address).and_return(forecast_service)
        expect(forecast_service).to receive(:current_temp).and_return(current_temp)
        expect(forecast_service).to receive(:current_cached).and_return(false)
        post forecasts_path, params: { address: address }
        expect(response.parsed_body['current_temp']).to eq(current_temp)
      end
    end
  end
end
