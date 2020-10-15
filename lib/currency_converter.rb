require_relative 'service_wrap.rb'

class CurrencyConverter
  include ServiceWrap

  attr_reader :from, :to, :amount

  def initialize(from, to, amount)
    @from = from
    @to = to
    @amount = amount
  end

  def input_interpret(input); end

  def converter
    # url = url(@from, @to)
    # exchange_rate(url)["#{@from}_#{@to}"]
    ex = exchange_rate(@from, @to)
    ex.nil? ? 'service down' : ex * @amount
  end
end

x = CurrencyConverter.new('USD', 'EGP', 870)
pp x.converter

# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
# pp x.exchange_rate
