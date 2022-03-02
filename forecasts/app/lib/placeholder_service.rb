class PlaceholderService
  SECONDS_IN_DAYS = 60 * 60 * 24
  BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze
  def initialize
    @client = CachedRequestService.new(BASE_URL)
  end

  def fetch_by_zipcode(_zipcode)
    @client.get('/todos/1')
  end
end
