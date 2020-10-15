# ruby service wrap for
# Getting a rate
# rate = response_obj['conversion_rates']['EUR']

module ServiceWrap2
  require 'httparty'
  require 'json'
  API = 'f7fe82122b36a865866bab5b'.freeze
  VERSION = 'v6'.freeze
  SERVICE_URL = "https://#{VERSION}.exchangerate-api.com/#{VERSION}/#{API}/latest/".freeze
  private_constant :API

  def exchange_rate(base)
    HTTParty.get(SERVICE_URL + base).parsed_response
  end
end
