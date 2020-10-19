require_relative 'service_wrapper_2.rb'
class CurrencyConverter
  include ServiceWrap2
  attr_reader :pairs, :amount, :currenices, :interpreted_input

  def initialize(input)
    @currenices = CurrencyConverter::CURRENICES

    @pairs = []
    @interpreted_input = input_interpret(input)
  end

  def converter_format
    result = []
    rate = converter

    i = 1
    while i < rate.length
      result << "#{amount} #{pairs[0]}  =  #{amount * rate[i]} #{pairs[i]} "
      i += 1
    end

    result
  end

  private

  def input_interpret(input)
    interpreted_input = []
    input = delete_first_spaces(input)
    # extract amount and update input
    input = extract_amount(input)
    # wrong input in the form '100 12 USD'
    # check if it's now '12 USD' after running extract_amount()
    raise 'check input' unless input.to_f.zero?

    return if input.nil?

    until input.length.zero?
      input = delete_first_spaces(input)
      input_arry = extract_currency(input)
      interpreted_input << input_arry[0] unless input_arry[0].empty? || !input_arry[0].to_i.zero?
      input = input_arry[1]
    end
    interpreted_input
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

  def converter
    @pairs = mapping

    @pairs = %w[USD EUR GBP AUD JPY CAD EGP] if @pairs.empty?
    @pairs += %w[USD EUR GBP AUD JPY CAD] if @pairs.length == 1
    @pairs = uniq_pairs(pairs)
    exchange_rate(@pairs)
  end

  def mapping
    local_pairs = []
    @interpreted_input.each do |user_input|
      # search by code
      @currenices.each { |code| local_pairs << user_input.upcase if code[0] == user_input.upcase.to_sym }
      # search by country or currency name
      @currenices.each do |code|
        local_pairs << code[0].to_s if code[1][1] == user_input.upcase || code[1][0] == user_input.upcase
        # EU countries case
        if code[1][1].is_a?(Array)
          code[1][1].each { |europe_country| local_pairs << code[0].to_s if europe_country == user_input.upcase }
        end
      end
    end
    local_pairs
  end

  def uniq_pairs(pairs)
    pairs.uniq
  end
end
