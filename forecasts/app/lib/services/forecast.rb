module Services
  class Forecast
    BASE_URL = 'http://api.wunderground.com'.freeze
    def initialize(address)
      @address = address
    end

    def fetch_forecast
      @client = Faraday.new do |builder|
        builder.use Faraday::HttpCache, store: Rails.cache, logger: ActiveSupport::Logger.new($stdout)
        builder.adapter Faraday.default_adapter
        builder.response :json, content_type: /\bjson$/
      end
      response = @client.get('https://jsonplaceholder.typicode.com/todos/1')
      response.body
    end
  end
end
