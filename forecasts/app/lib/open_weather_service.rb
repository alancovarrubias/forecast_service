class OpenWeatherService
  SECONDS_IN_DAYS = 60 * 60 * 24
  BASE_URL = 'http://api.openweathermap.org'.freeze
  def initialize(dependencies = {})
    @api_key = ENV['OPEN_WEATHER_API_KEY']
    @client = dependencies[:request_service] || CachedRequestService.new(BASE_URL)
  end

  def fetch_by_zipcode(zipcode)
    @client.get("/data/2.5/weather?zip=#{zipcode}&appid=#{@api_key}")
  end

  def method_missing(method, *args, &block)
    if method =~ /cache.*/
      @client.send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    method =~ /cache.*/ || super
  end
end
