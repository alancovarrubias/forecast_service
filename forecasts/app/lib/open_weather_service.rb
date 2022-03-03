module OpenWeatherService
  BASE_URL = 'http://api.openweathermap.org'.freeze
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def self.current_weather_by_zipcode(zipcode)
    CachedRequestService.new(BASE_URL).get("/data/2.5/weather?zip=#{zipcode}&units=imperial&appid=#{API_KEY}")
  end
end
