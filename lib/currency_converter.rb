# ruby service wrap for FreeCurrencyConverterApi
require 'open-uri'
require 'json'

class CurrencyConverter
    API = '4577dd24ef319e6f3fc3'
    
  attr_reader :local_c, :forien_c
  

  def initialize(local_c, forien_c)
    @local_c = local_c
    @forien_c = forien_c
 end
