class ForecastsController < ApplicationController
  def create
    render json: { forecast: {}, address: params[:address] }
  end
end
