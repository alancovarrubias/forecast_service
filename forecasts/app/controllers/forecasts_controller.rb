class ForecastsController < ApplicationController
  def create
    forecast = Services::Forecast.new(forecast_params.to_h)
    render json: { forecast: forecast.fetch_forecast, address: params[:address] }
  end

  def forecast_params
    params.require(:address).permit(:zipcode)
  end
end
