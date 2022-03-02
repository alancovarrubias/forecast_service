class ForecastsController < ApplicationController
  def create
    forecast = ForecastService.new(address_params.to_h)
    render json: { forecast: forecast.fetch }
  end

  def address_params
    params.require(:address).permit(:zipcode)
  end
end
