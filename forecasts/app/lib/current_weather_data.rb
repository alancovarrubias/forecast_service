class CurrentWeatherData
  def initialize(zipcode)
    @weather_response = OpenWeatherService.current_weather_by_zipcode(zipcode)
  end

  def current_temp
    temperature['temp']
  end

  def current_low
    temperature['temp_min']
  end

  def current_high
    temperature['temp_max']
  end

  def current_cached
    @weather_response[:cached]
  end

  private

  def temperature
    @weather_response[:body]['main']
  end
end
