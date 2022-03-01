require 'rails_helper'

RSpec.describe 'Forecastr', type: :request do
  before do
    @address = {}
  end

  describe 'POST /forecasts' do
    it 'responds successfully' do
      post forecasts_path
      expect(response).to have_http_status(200)
    end

    it 'returns address in response' do
      post forecasts_path, params: { address: { zipcode: '93065' } }
      expect(response.parsed_body).to eq({ 'forecast' => {}, 'address' => { 'zipcode' => '93065' } })
    end
  end
end
