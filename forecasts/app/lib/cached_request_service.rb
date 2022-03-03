class CachedRequestService
  SECONDS_IN_DAYS = 60 * 60 * 24
  EXPIRATION_DAYS = 30

  def initialize(url)
    @client = Faraday.new(url) do |builder|
      builder.use Faraday::HttpCache, store: Rails.cache, instrumenter: ActiveSupport::Notifications
      builder.use Faraday::Response::RaiseError
      builder.adapter Faraday.default_adapter
      builder.response :json, content_type: /\bjson$/
    end
    @cache_data = CacheData.new
  end

  def get(path, params = {})
    prev_cache_hits = @cache_data.hits
    start_time = Time.now
    response = @client.get(path) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Cache-Control'] = "max-age=#{SECONDS_IN_DAYS * EXPIRATION_DAYS}"
      req.url(path, params)
    end

    time_taken_ms = (Time.now - start_time) * 1000
    puts "Time Taken: #{time_taken_ms.round(3)} ms"
    { body: response.body, cached: prev_cache_hits < @cache_data.hits }
  end
end
