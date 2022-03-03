class PlaceholderService
  BASE_URL = 'https://jsonplaceholder.typicode.com'.freeze
  def initialize
    @client = CachedRequestService.new(BASE_URL)
  end

  def placeholder_todos
    @client.get('/todos/1')
  end
end
