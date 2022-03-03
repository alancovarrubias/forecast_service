require 'rails_helper'

RSpec.describe 'Forecast', type: :request do
  let(:params) { { address: { zipcode: '93065' } } }
  describe 'POST /forecasts' do
    it 'responds successfully' do
      VCR.use_cassette('current_temp') do
        post api_v1_forecasts_path, params: params
        expect(response).to have_http_status(200)
      end
    end

    describe 'forecast fetching' do
      let(:forecast_service) { double(ForecastService) }
      let(:current_temp) { 59.9 }
      let(:current_low) { 49.9 }
      let(:current_high) { 69.9 }
      it 'returns forecast from external weather api' do
        expect(ForecastService).to receive(:new).with(params[:address]).and_return(forecast_service)
        expect(forecast_service).to receive(:current_temp).and_return(current_temp)
        expect(forecast_service).to receive(:current_high).and_return(current_high)
        expect(forecast_service).to receive(:current_low).and_return(current_low)
        expect(forecast_service).to receive(:current_cached).and_return(false)
        post api_v1_forecasts_path, params: params
        expect(response.parsed_body['current_temp']).to eq(current_temp)
        expect(response.parsed_body['current_high']).to eq(current_high)
        expect(response.parsed_body['current_low']).to eq(current_low)
      end
    end
  end
end
