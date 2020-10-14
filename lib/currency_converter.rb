# ruby service wrap for FreeCurrencyConverterApi
require 'open-uri'
require 'json'

class CurrencyConverter
  API = '4577dd24ef319e6f3fc3'.freeze
  SERVICE_URL = 'https://free.currconv.com'.freeze
  @api_version = 'v7'
  private_constant :API

  attr_reader :local_c, :forien_c

  def initialize; end

  def rate
    #open("#{SERVICE_URL}/api/v7/convert?q=USD_EGP,EGP_USD&compact=ultra&apiKey=#{API}").read
    URI.parse("#{SERVICE_URL}/api/v7/convert?q=USD_EGP,EGP_USD&compact=ultra&apiKey=#{API}").open
  end
end

x = CurrencyConverter.new
pp response = x.rate
json = JSON.parse(response)
pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
