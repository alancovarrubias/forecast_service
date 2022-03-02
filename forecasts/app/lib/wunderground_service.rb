class WundergroundService
  SECONDS_IN_DAYS = 60 * 60 * 24
  BASE_URL = 'http://api.wunderground.com'.freeze
  def initialize(dependencies = {})
    @api_key = ENV['WUNDERGROUND_API_KEY']
    @client = dependencies[:request_service] || CachedRequestService.new(BASE_URL)
  end

  def fetch_by_zipcode(zipcode)
    @client.get("/api/#{@api_key}/forecast/q/#{zipcode}.json")
  end

  def method_missing(method, *args, &block)
    if method =~ /cache.*/
      @client.send(method, *args, &block)
    else
      super
    end
  end

  def respond_to_missing?(method, include_private = false)
    method =~ /cache.*/ || super
  end
end
