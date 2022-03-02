class ForecastService
  def initialize(address, dependencies = {})
    @address = address
    @client = dependencies[:client] || WundergroundService.new
  end

  def fetch
    @client.fetch_by_zipcode(@address['zipcode'])
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
