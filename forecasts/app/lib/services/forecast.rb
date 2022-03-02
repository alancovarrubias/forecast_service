module Services
  class Forecast
    SECONDS_IN_DAYS = 60 * 60 * 24
    BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze
    def initialize(_address)
      @client = CachedRequestService.new(BASE_URL)
    end

    def fetch_forecast
      @client.get('/todos/1')
    end
  end
end
