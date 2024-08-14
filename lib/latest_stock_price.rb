require 'net/http'
require 'json'

class LatestStockPrice
  BASE_URL = 'https://latest-stock-price.p.rapidapi.com'
  API_KEY = ENV['RAPIDAPI_KEY'] # Fetch the API key from environment variable

  def initialize
    @uri = URI(BASE_URL)
  end

  def fetch_price(symbol)
    response = make_request("price/#{symbol}")
    JSON.parse(response.body)
  end

  def fetch_prices
    response = make_request('prices')
    JSON.parse(response.body)
  end

  def fetch_price_all
    response = make_request('any')
    JSON.parse(response.body)
  end

  private

  def make_request(endpoint)
    uri = URI.join(BASE_URL, endpoint)
    request = Net::HTTP::Get.new(uri)
    request['x-rapidapi-host'] = 'latest-stock-price.p.rapidapi.com'
    request['x-rapidapi-key'] = API_KEY

    Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      response = http.request(request)
      response
    end
  end
end
