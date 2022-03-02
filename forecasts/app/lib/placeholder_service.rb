class PlaceholderService
  SECONDS_IN_DAYS = 60 * 60 * 24
  BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze
  def initialize(dependencies = {})
    @client = dependencies[:request_service] || CachedRequestService.new(BASE_URL)
  end

  def fetch_by_zipcode(_zipcode)
    @client.get('/todos/1')
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
