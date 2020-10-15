require 'json'
require 'httparty'

country = HTTParty.get('https://free.currconv.com/api/v7/countries?apiKey=do-not-use-this-key')
country = country.parsed_response
# pp country.class

x = country['results'].select do |arr|
  input = 'Eg'
  arr[0] =~ Regexp.new(input)
end

pp x
