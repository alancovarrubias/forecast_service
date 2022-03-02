class ForecastsController < ApplicationController
  before_action :setup_service
  def create
    render json: { forecast: @service.fetch }
  end

  def setup_service
    @service = ForecastService.new(address_params.to_h)
  end

  def address_params
    params.require(:address).permit(:zipcode)
  end
end
