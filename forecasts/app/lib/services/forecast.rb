module Services
  class Forecast
    SECONDS_IN_DAYS = 60 * 60 * 24
    BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze
    def initialize(_address)
      @client = Faraday.new(BASE_URL) do |builder|
        builder.use :http_cache, store: Rails.cache, instrumenter: ActiveSupport::Notifications
        builder.adapter Faraday.default_adapter
        builder.response :json, content_type: /\bjson$/
      end
    end

    def fetch_forecast
      response = @client.get('/todos/1') do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Cache-Control'] = "max-age=#{SECONDS_IN_DAYS * 30}"
      end
      response.body
    end
  end
end
