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

  def exchange_rate(pairs)
    # ex_rate = []
    # response = HTTParty.get(SERVICE_URL + pairs[0]).parsed_response
    # #return ex_rate << responseresponse['conversion_rates'][code] if pairs.length == 1
    # pairs.each { |code| ex_rate << response['conversion_rates'][code] }
    # ex_rate
    ex_rate = []
    response = HTTParty.get(SERVICE_URL + pairs[0]).parsed_response
    if pairs.length == 1
      response['conversion_rates'].to_a

    else
      pairs.each { |code| ex_rate << response['conversion_rates'][code] }
      ex_rate
    end
 end
end
