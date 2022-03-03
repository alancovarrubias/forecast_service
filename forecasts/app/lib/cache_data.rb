class CacheData
  attr_reader :hits, :misses

  def initialize
    @hits = 0
    @misses = 0
    ActiveSupport::Notifications.subscribe 'http_cache.faraday' do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
      cache_status = event.payload[:cache_status]
      case cache_status
      when :fresh, :valid
        @hits += 1
      when :invalid, :miss
        @misses += 1
      end
    end
  end
end
