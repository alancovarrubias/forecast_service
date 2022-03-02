module Services
  class CachedRequestService
    SECONDS_IN_DAYS = 60 * 60 * 24
    def initialize(url)
      @client = Faraday.new(url) do |builder|
        builder.use :http_cache, store: Rails.cache, instrumenter: ActiveSupport::Notifications
        builder.adapter Faraday.default_adapter
        builder.response :json, content_type: /\bjson$/
      end
    end

    def get(path, days = 30)
      @client.get(path) do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['Cache-Control'] = "max-age=#{SECONDS_IN_DAYS * days}"
      end
    end
  end
end
