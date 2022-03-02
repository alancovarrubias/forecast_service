class CachedRequestService
  SECONDS_IN_DAYS = 60 * 60 * 24
  attr_reader :cache_hits, :cache_misses

  def initialize(url)
    @client = Faraday.new(url) do |builder|
      builder.use :http_cache, store: Rails.cache, instrumenter: ActiveSupport::Notifications
      builder.adapter Faraday.default_adapter
      builder.response :json, content_type: /\bjson$/
    end
    @cache_hits = 0
    @cache_misses = 0
    setup_notifications
  end

  def get(path, days = 30)
    prev_cache_hits = @cache_hits
    response = @client.get(path) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.headers['Cache-Control'] = "max-age=#{SECONDS_IN_DAYS * days}"
    end
    { body: response.body, cached: prev_cache_hits < @cache_hits }
  end

  private

  def setup_notifications
    ActiveSupport::Notifications.subscribe 'http_cache.faraday' do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
      cache_status = event.payload[:cache_status]
      case cache_status
      when :fresh, :valid
        @cache_hits += 1
      when :invalid, :miss
        @cache_misses += 1
      end
    end
  end
end
