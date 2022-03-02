class WundergroundService
  SECONDS_IN_DAYS = 60 * 60 * 24
  BASE_URL = 'http://api.wunderground.com'.freeze
  def initialize
    @api_key = ENV['WUNDERGROUND_API_KEY']
    @client = CachedRequestService.new(BASE_URL)
  end

  def fetch_by_zipcode(zipcode)
    @client.get("/api/#{@api_key}/forecast/q/#{zipcode}.json")
  end
end
