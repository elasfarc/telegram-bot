require_relative 'service_wrapper_2.rb'
class CurrencyConverter
  # include ServiceWrap
  include ServiceWrap2

  attr_reader :pairs
  attr_reader :amount, :currenices

  def initialize(input)
    @currenices = {
      AED: ['UAE Dirham', 'United Arab Emirates'],
      ARS: ['Argentine Peso', 'Argentina'],
      AUD: ['Australian Dollar', 'Australia'],
      BGN: ['Bulgarian Lev', 'Bulgaria'],
      BRL: ['Brazilian Real', 'Brazil'],
      BSD: ['Bahamian Dollar', 'Bahamas'],
      CAD: ['Canadian Dollar', 'Canada'],
      CHF: ['Swiss Franc', 'Switzerland'],
      CLP: ['Chilean Peso', 'Chile'],
      CNY: ['Chinese Renminbi', 'China'],
      COP: ['Colombian Peso', 'Colombia'],
      CZK: ['Czech Koruna', 'Czech Republic'],
      DKK: ['Danish Krone', 'Denmark'],
      DOP: ['Dominican Peso', 'Dominican Republic'],
      EGP: ['Egyptian Pound', 'Egypt'],
      EUR: ['Euro', %w[Germany Austria Belgium Cyprus Estonia Finland France Greece Ireland Italy Latvia Lithuania Malta Netherlands Portugal Slovakia Slovenia Spain]],
      FJD: ['Fiji Dollar', 'Fiji'],
      GBP: ['Pound Sterling', 'United Kingdom'],
      GTQ: ['Guatemalan Quetzal', 'Guatemala'],
      HKD: ['Hong Kong Dollar', 'Hong Kong'],
      HRK: ['Croatian Kuna', 'Croatia'],
      HUF: ['Hungarian Forint', 'Hungary'],
      IDR: ['Indonesian Rupiah', 'Indonesia'],
      ILS: ['Israeli New Shekel', 'Israel'],
      INR: ['Indian Rupee', 'India'],
      ISK: ['Icelandic Krona', 'Iceland'],
      JPY: ['Japanese Yen', 'Japan'],
      KRW: ['South Korean Won', 'South Korea'],
      KZT: ['Kazakhstani Tenge', 'Kazakhstan'],
      MVR: ['Maldivian Rufiyaa', 'Maldives'],
      MXN: ['Mexican Peso', 'Mexico'],
      MYR: ['Malaysian Ringgit', 'Malaysia'],
      NOK: ['Norwegian Krone', 'Norway'],
      NZD: ['New Zealand Dollar', 'New Zealand'],
      PAB: ['Panamanian Balboa', 'Panama'],
      PEN: ['Peruvian Sol', 'Peru'],
      PHP: ['Philippine Peso', 'Philippines'],
      PKR: ['Pakistani Rupee', 'Pakistan'],
      PLN: ['Polish Zloty', 'Poland'],
      PYG: ['Paraguayan Guarani', 'Paraguay'],
      RON: ['Romanian Leu', 'Romania'],
      RUB: ['Russian Ruble', 'Russia'],
      SAR: ['Saudi Riyal', 'Saudi Arabia'],
      SEK: ['Swedish Krona', 'Sweden'],
      SGD: ['Singapore Dollar', 'Singapore'],
      THB: ['Thai Baht', 'Thailand'],
      TRY: ['Turkish Lira', 'Turkey'],
      TWD: ['New Taiwan Dollar', 'Taiwan'],
      UAH: ['Ukrainian Hryvnia', 'Ukraine'],
      USD: ['United States Dollar', 'United States'],
      UYU: ['Uruguayan Peso', 'Uruguay'],
      ZAR: ['South African Rand', 'South Africa']
    }
    @pairs = []
    input_interpret(input)
  end

  def mapping
    local_pairs = []
    @pairs.each do |user_input|
      # search by code
      @currenices.each { |code| local_pairs << user_input.upcase if code[0] == user_input.upcase.to_sym }

      # search by country or currency name
      @currenices.each do |code|
        if code[1][1].include?(user_input.capitalize) || code[1][0].include?(user_input.capitalize)
          local_pairs << code[0].to_s
        end
      end
    end
    local_pairs.uniq
  end

  def input_interpret(input)
    input = delete_first_spaces(input)
    # extract amount and update input
    input = extract_amount(input)
    return 'check input' unless input.to_f.zero?
    return if input.nil?

    until input.length.zero?
      input = delete_first_spaces(input)
      # pp input
      input_arry = extract_currency(input)
      @pairs << input_arry[0] unless input_arry[0].empty? || !input_arry[0].to_i.zero?
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

  def converter
    @pairs = mapping
    @pairs = ['USD'] if @pairs.empty?
    exchange_rate(@pairs)
  end

  def converter_format
    result = []
    rate = converter
    if pairs.length == 1
        rate = rate.drop(1)
       rate.map { |el| result << "#{amount} #{pairs[0]} = #{amount * el[1]} #{el[0]} " }
    else
        i = 1
      while i < rate.length
        result << "#{amount} #{pairs[0]} = #{amount * rate[i]} #{pairs[i]} "
        i += 1
      end
    end
    result
  end
  
end

# x = CurrencyConverter.new('         5.2        usd  egp  egypt cad lklk 5 5 665 euro france pound United States eur')
#x = CurrencyConverter.new('         5.2        usd  egp  egypt cad lklk 5 5 665 euro france  eur')
 #x = CurrencyConverter.new('         870')

# pp x.pairs
 #pp x.amount
# pp x.converter
# pp x.converter
# pp x.mapping

# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
# pp x.exchange_rate

#puts x.converter_format
