# ruby service wrap for FreeCurrencyConverterApi
module ServiceWrap
  require 'httparty'
  require 'json'
  API = '4577dd24ef319e6f3fc3'.freeze
  SERVICE_URL = 'https://free.currconv.com'.freeze
  VERSION = 'v7'.freeze
  private_constant :API

  def url(indicator)
    # "#{SERVICE_URL}/api/#{VERSION}/convert?q=#{from}_#{to}&compact=ultra&apiKey=#{API}"
    # "#{SERVICE_URL}/api/#{VERSION}/convert?q=#{from}_#{to}&compact=ultra&apiKey=#{API}"
    # "#{SERVICE_URL}/api/#{VERSION}/countries?apiKey=#{API}"
    # s = indicator == "convert" ? "convert?q=#{from}_#{to}&compact=ultra&" : "countries?"
    "#{SERVICE_URL}/api/#{VERSION}/#{indicator}/apiKey=#{API}"
  end

  def countries_list
    indicator = 'countries?'
    HTTParty.get(url(indicator)).parsed_response
  end

  def exchange_rate(from, to)
    indicator = "convert?q=#{from}_#{to}&compact=ultra&"
    response = HTTParty.get(url(indicator))
    response.parsed_response["#{from}_#{to}"]
  end
end
