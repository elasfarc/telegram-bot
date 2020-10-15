require_relative 'service_wrapper_2.rb'
class CurrencyConverter
  include ServiceWrap
  include ServiceWrap2

  attr_reader :from, :to, :amount

  def initialize(_base, to = nil, amount = 1)
    @from = from
    @to = to
    @amount = amount
  end

  def input_interpret(input)
    # delete first space if there was any
    while input.index(' ').zero?
      input = input[1..-1]
      break if input.index(' ').nil?
    end
    # extract amount and update input
    if input.to_f.zero?
      @amount = 1
    else
      @amount = input.to_f
      # no fraction provided
      slice = if input.to_f == input.to_i
                input.to_i.to_s.length + 1
              else
                input.to_f.to_s.length + 1
              end
      input = input[slice..-1]
      return "check your input" unless input.to_f.zero?
    end

    



    # input.to_f.zero? ? (@amount = 1) : (@amount = input.to_f)
  end

  def converter_2(base)
    exchange_rate(base)
  end
end

x = CurrencyConverter.new('USD', 'EGP', 870)
# pp x.converter
pp x.converter_2('USD')

# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
# pp x.exchange_rate
