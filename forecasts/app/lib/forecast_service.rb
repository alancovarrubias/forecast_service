class ForecastService
  def initialize(address)
    @cache_data = CacheData.new
    @current_weather = CurrentWeatherData.new(address['zipcode'])
    @placeholder = PlaceholderService.new
  end

  def method_missing(method, *args, &block)
    case method
    when /current.*/
      @current_weather.send(method, *args, &block)
    when /cache.*/
      @cache_data.send(method, *args, &block)
    when /placeholder.*/
      @placeholder.send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    method =~ /current.*/ || super
  end
end
