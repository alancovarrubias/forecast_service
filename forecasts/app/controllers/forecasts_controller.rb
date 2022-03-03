class ForecastsController < ApplicationController
  before_action :setup_service
  def create
    render json: {
      current_temp: @service.current_temp,
      current_low: @service.current_low,
      current_high: @service.current_high,
      cached: @service.current_cached
    }
  end

  def setup_service
    @service = ForecastService.new(address_params.to_h)
  end

  def address_params
    params.require(:address).permit(:zipcode)
  end
end
