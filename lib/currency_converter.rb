require_relative 'service_wrapper_2.rb'
class CurrencyConverter
  # include ServiceWrap
  include ServiceWrap2

  attr_reader :currenices
  attr_reader :amount
  def initialize(input)
    @currenices = []
    input_interpret(input)
  end

  def input_interpret(input)
    input = delete_first_spaces(input)
    # extract amount and update input
    input = extract_amount(input)
    return 'check input' unless input.to_f.zero?
    return if input.nil?

    until input.length.zero?
      input = delete_first_spaces(input)
      pp input
      input_arry = extract_currency(input)
      @currenices << input_arry[0] unless input_arry[0].empty? || !input_arry[0].to_i.zero? 
      input = input_arry[1]
    end
  end

  def delete_first_spaces(input)
    # delete first space if there was any
    return input if input.index(' ').nil?

    while input.index(' ').zero?
      input = input[1..-1]
      break if input.index(' ').nil?
    end
    input
  end

  def extract_amount(input)
    if input.to_f.zero?
      @amount = 1
    else
      @amount = input.to_f
      # no fraction provided
      slice = if input.to_f == input.to_i
                input.to_i.to_s.length
              else
                input.to_f.to_s.length
              end
      # return 'check your input' unless input.to_f.zero?

      input = input[slice..-1]
    end
    delete_first_spaces(input)
  end

  def extract_currency(input)
    return [input, ''] if input.index(' ').nil?

    slice = input.index(' ')
    currency = input[0...slice]
    [currency, input[currency.length..-1]]
  end

  def converter_2(base)
    # exchange_rate(base)
  end
end

x = CurrencyConverter.new('         5.2        usd  egp cad lklk 5 5 665')
pp x.currenices
pp x.amount
# pp x.converter
# pp x.converter_2('USD')

# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
# pp x.exchange_rate
