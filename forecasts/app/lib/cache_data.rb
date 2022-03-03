class CacheData
  attr_reader :cache_hits, :cache_misses

  def initialize
    @cache_hits = 0
    @cache_misses = 0
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
