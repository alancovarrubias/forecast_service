class CurrentWeatherData
  def initialize(zipcode)
    @weather_response = OpenWeatherService.current_weather_by_zipcode(zipcode)
  end

  def current_temp
    response_body['main']['temp']
  end

  def current_cached
    @weather_response[:cached]
  end

  private

  def response_body
    @weather_response[:body]
  end
end
