require_relative 'service_wrap.rb'

class CurrencyConverter
  include ServiceWrap

  attr_reader :from, :to
 

  def initialize(from, to)
    @from = from
    @to = to
  end

  def rate
    urll = url(@from, @to)
    exchange_rate(urll)
  end

end

 x = CurrencyConverter.new('USD', 'EGP')
    #pp x.rate
    
# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
#pp x.exchange_rate
