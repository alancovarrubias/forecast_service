class ForecastService
  def initialize(address, dependencies = {})
    @address = address
    @client = dependencies[:client] || WundergroundService.new
  end

  def fetch
    @client.fetch_by_zipcode(@address['zipcode'])
  end
end
