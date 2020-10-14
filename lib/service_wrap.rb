# ruby service wrap for FreeCurrencyConverterApi
module ServiceWrap
  require 'httparty'
  require 'json'
  API = '4577dd24ef319e6f3fc3'.freeze
  SERVICE_URL = 'https://free.currconv.com'.freeze
  VERSION = 'v7'.freeze
  private_constant :API

  def url(from, to)
    "#{SERVICE_URL}/api/#{VERSION}/convert?q=#{from}_#{to}&compact=ultra&apiKey=#{API}"
  end

  def exchange_rate(from, to)
    response = HTTParty.get(url(from, to))
    response.parsed_response["#{from}_#{to}"]
  end
end

# pp ServiceWrap.exchange_rate('https://free.currconv.com/api/v7/convert?q=_&compact=ultra&apiKey=4577dd24ef319e6f3fc3')

# pp ServiceWrap::API
