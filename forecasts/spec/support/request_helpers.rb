# spec/support/request_helpers.rb
module Requests
  module JsonHelpers
    def data
      JSON.parse(response.body)['data']
    end

    def read_json_file(file)
      absolute_path = File.expand_path("files/#{file}", __dir__)
      file = File.read(absolute_path)
      JSON.parse(file)
    end
  end
end
