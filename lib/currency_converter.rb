require_relative 'service_wrapper_2.rb'
class CurrencyConverter
  # include ServiceWrap
  include ServiceWrap2

  attr_reader :pairs
  attr_reader :amount, :currenices

  def initialize(input)
    @currenices = {
      AED: ['UAE-DIRHAM', 'UNITED-ARAB-EMIRATES'],
      ARS: %w[ARGENTINE-PESO ARGENTINA],
      AUD: %w[AUSTRALIAN-DOLLAR AUSTRALIA],
      BGN: %w[BULGARIAN-LEV BULGARIA],
      BRL: %w[BRAZILIAN-REAL BRAZIL],
      BSD: %w[BAHAMIAN-DOLLAR BAHAMAS],
      CAD: %w[CANADIAN-DOLLAR CANADA],
      CHF: %w[SWISS-FRANC SWITZERLAND],
      CLP: %w[CHILEAN-PESO CHILE],
      CNY: %w[CHINESE-RENMINBI CHINA],
      COP: %w[COLOMBIAN-PESO COLOMBIA],
      CZK: %w[CZECH-KORUNA CZECH-REPUBLIC],
      DKK: %w[DANISH-KRONE DENMARK],
      DOP: %w[DOMINICAN-PESO DOMINICAN-REPUBLIC],
      EGP: %w[EGYPTIAN-POUND EGYPT],
      EUR: ['EURO', %w[GERMANY AUSTRIA BELGIUM CYPRUS ESTONIA FINLAND FRANCE GREECE IRELAND ITALY LATVIA LITHUANIA MALTA NETHERLANDS PORTUGAL SLOVAKIA SLOVENIA SPAIN]],
      FJD: %w[FIJI-DOLLAR FIJI],
      GBP: %w[POUND-STERLING UNITED-KINGDOM],
      GTQ: %w[GUATEMALAN-QUETZAL GUATEMALA],
      HKD: %w[HONG-KONG-DOLLAR HONG-KONG],
      HRK: %w[CROATIAN-KUNA CROATIA],
      HUF: %w[HUNGARIAN-FORINT HUNGARY],
      IDR: %w[INDONESIAN-RUPIAH INDONESIA],
      ILS: %w[ISRAELI-NEW-SHEKEL ISRAEL],
      INR: %w[INDIAN-RUPEE INDIA],
      ISK: %w[ICELANDIC-KRONA ICELAND],
      JPY: %w[JAPANESE-YEN JAPAN],
      KRW: %w[SOUTH-KOREAN-WON SOUTH-KOREA],
      KZT: %w[KAZAKHSTANI-TENGE KAZAKHSTAN],
      MVR: %w[MALDIVIAN-RUFIYAA MALDIVES],
      MXN: %w[MEXICAN-PESO MEXICO],
      MYR: %w[MALAYSIAN-RINGGIT MALAYSIA],
      NOK: %w[NORWEGIAN-KRONE NORWAY],
      NZD: %w[NEW-ZEALAND-DOLLAR NEW-ZEALAND],
      PAB: %w[PANAMANIAN-BALBOA PANAMA],
      PEN: %w[PERUVIAN-SOL PERU],
      PHP: %w[PHILIPPINE-PESO PHILIPPINES],
      PKR: %w[PAKISTANI-RUPEE PAKISTAN],
      PLN: %w[POLISH-ZLOTY POLAND],
      PYG: %w[PARAGUAYAN-GUARANI PARAGUAY],
      RON: %w[ROMANIAN-LEU ROMANIA],
      RUB: %w[RUSSIAN-RUBLE RUSSIA],
      SAR: %w[SAUDI-RIYAL SAUDI-ARABIA],
      SEK: %w[SWEDISH-KRONA SWEDEN],
      SGD: %w[SINGAPORE-DOLLAR SINGAPORE],
      THB: %w[THAI-BAHT THAILAND],
      TRY: %w[TURKISH-LIRA TURKEY],
      TWD: %w[NEW-TAIWAN-DOLLAR TAIWAN],
      UAH: %w[UKRAINIAN-HRYVNIA UKRAINE],
      USD: %w[UNITED-STATES-DOLLAR UNITED-STATES],
      UYU: %w[URUGUAYAN-PESO URUGUAY],
      ZAR: %w[SOUTH-AFRICAN-RAND SOUTH-AFRICA]
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
        local_pairs << code[0].to_s if code[1][1] == (user_input.upcase) || code[1][0] == (user_input.upcase)
      end
    end
    local_pairs
  end

  def input_interpret(input)
    input = delete_first_spaces(input)
    # extract amount and update input
    input = extract_amount(input)
    # wrong input in the form '100 12 USD'
    # check if it's now '12 USD' after running extract_amount()
    raise 'check input' unless input.to_f.zero?

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
    @pairs = %w[USD EUR GBP AUD JPY CAD EGP] if @pairs.empty?
    @pairs += %w[USD EUR GBP AUD JPY CAD] if @pairs.length == 1
    @pairs = uniq_pairs(pairs)
    exchange_rate(@pairs)
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

  def uniq_pairs(pairs)
    pairs.uniq
  end
end

# x = CurrencyConverter.new('         5.2        usd  egp  egypt cad lklk 5 5 665 euro france pound United States eur')
# x = CurrencyConverter.new('         5.2        usd  egp  egypt cad lklk 5 5 665 euro france  eur')
# x = CurrencyConverter.new('         870')

# pp x.pairs
# pp x.amount
# pp x.converter
# pp x.converter
# pp x.mapping

# pp response = x.rate
# json = JSON.parse(response)
# pp json['USD_EGP']
# arry = json.hash.to_a
# pp arry[0]
# pp x.exchange_rate

# puts x.converter_format

x = CurrencyConverter.new('1000   usd')
# pp x.input_interpret('5 5.5' )
pp x.amount
pp x.pairs
pp x.converter
