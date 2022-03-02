module Services
  class Forecast
    def initialize(address, dependencies = {})
      @address = address
      @client = dependencies[:client] || WundergroundService.new
    end

    def fetch_forecast
      @client.fetch_by_zipcode(@address['zipcode'])
    end
  end
end
