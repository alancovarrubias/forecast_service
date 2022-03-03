class ForecastService
  def initialize(address)
    @current_weather = CurrentWeatherData.new(address['zipcode'])
  end

  def method_missing(method, *args, &block)
    if method =~ /current.*/
      @current_weather.send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    method =~ /current.*/ || super
  end
end
