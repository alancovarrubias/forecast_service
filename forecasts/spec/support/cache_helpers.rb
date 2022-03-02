# test/support/rails_cache_helper.rb:
module CacheHelpers
  def with_clean_caching
    Rails.cache.clear
    yield
  ensure
    Rails.cache.clear
  end

  def cache_has_value?(value)
    cache_data.values.map(&:value).any?(value)
  end

  def faraday_cache_counts
    hits = 0
    misses = 0
    ActiveSupport::Notifications.subscribe 'http_cache.faraday' do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
      cache_status = event.payload[:cache_status]
      case cache_status
      when :fresh, :valid
        hits += 1
      when :invalid, :miss
        misses += 1
      end
    end
    yield
    [hits, misses]
  end

  def first_cached_value
    cache_data.values.first.value
  end

  def key_for_cached_value(value)
    cache_data.each_value do |key, entry|
      return key if entry&.value == value
    end
  end

  def cache_data
    Rails.cache.instance_variable_get(:@data)
  end
end
