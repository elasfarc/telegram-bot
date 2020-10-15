# require 'json'
# require 'httparty'

# country = HTTParty.get('https://free.currconv.com/api/v7/countries?apiKey=do-not-use-this-key')
# country = country.parsed_response
# # pp country.class

# x = country['results'].select do |arr|
#   input = 'Eg'
#   arr[0] =~ Regexp.new(input)
# end

# pp x
# @other = []
# def input_interpret(input)
#   input = delete_first_spaces(input)
#   # pp input
#   # extract amount and update input
#   input = extract_amount(input)
#   # pp input

#   # pp input
#   return 'check input' unless input.to_f.zero?

#   until input.length.zero?
#     input = delete_first_spaces(input)
#     pp input
#     input_arry = extract_currency(input)
#     @other << input_arry[0] unless input_arry[0].empty?
#     input = input_arry[1]
#   end

#   # pp input
#   # pp "------"
#   # while (input.length)
# end

# def delete_first_spaces(input)
#   # delete first space if there was any
#   while input.index(' ').zero?
#     input = input[1..-1]
#     break if input.index(' ').nil?
#   end
#   input
# end

# def extract_amount(input)
#   if input.to_f.zero?
#     @amount = 1
#   else
#     @amount = input.to_f
#     # no fraction provided
#     slice = if input.to_f == input.to_i
#               input.to_i.to_s.length
#             else
#               input.to_f.to_s.length
#             end
#     # return 'check your input' unless input.to_f.zero?

#     input = input[slice..-1]
#   end
#   input = delete_first_spaces(input)
# end

# def extract_currency(input)
#   # pp "visted"
#   return returned_arry = [input, ''] if input.index(' ').nil?

#   # pp "visted 2"
#   slice = input.index(' ')
#   currency = input[0...slice]
#   # pp currency + "  ffff"
#   # pp input[currency.length..-1] + "  ffffff"
#   returned_arry = [currency, input[currency.length..-1]]
# end

def input_interpret(input)
  other = []
  input = delete_first_spaces(input)
  # extract amount and update input
  input = extract_amount(input)
  return 'check input' unless input.to_f.zero?
  return other if input.nil?

  # pp input
  until input.length.zero?
    input = delete_first_spaces(input)
    pp input
    input_arry = extract_currency(input)
    other << input_arry[0] unless input_arry[0].empty?
    input = input_arry[1]
  end
  other
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
  input = delete_first_spaces(input)
end

def extract_currency(input)
  return returned_arry = [input, ''] if input.index(' ').nil?

  slice = input.index(' ')
  currency = input[0...slice]
  returned_arry = [currency, input[currency.length..-1]]
end
pp input_interpret('    5 usd egp eur gdp cad 5 ')
pp @other
