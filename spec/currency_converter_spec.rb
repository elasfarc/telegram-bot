require_relative '../lib/currency_converter.rb'

RSpec.describe CurrencyConverter do

  describe 'constant API' do
    it 'can not be accessed outside the class' do
      expect { CurrencyConverter::API }.to raise_error NameError
    end
  end

  describe '#converter_format' do
    describe '#input_interpret' do
      context 'invalid user input' do
        context 'more than one amount is provided' do
          it 'should raise an error ' do
            input = '5.1 10000 USD EUR'
            begin
              CurrencyConverter.new(input)
            rescue StandardError
              invalid_input = true
            end
            expect(invalid_input).to eq(true)
          end
        end
      end
      context 'valid user input' do
        context 'starts with one or more space' do
          it 'should ignore the space/s and capture the amount' do
            input = '  5 USD EUR'
            converter = CurrencyConverter.new(input)
            expect(converter.amount).to eq(5)
          end
        end
        context 'more than one space between [currencies pairs]' do
          it 'should ignore the space/s' do
            input = '5 USD              EUR'
            converter = CurrencyConverter.new(input)
            expect(converter.interpreted_input).to eq(%w[USD EUR])
          end
        end
        context 'no space between amount and v1 ∈ [currencies pairs] ' do
          it 'should capture the amount' do
            input = '5USD EUR'
            converter = CurrencyConverter.new(input)
            expect(converter.amount).to eq(5)
          end
        end
        describe 'all arguments are optional' do
          context 'no [amount] is  provided' do
            example 'amount should eq 1.0' do
              input = 'USD EUR'
              converter = CurrencyConverter.new(input)
              expect(converter.amount).to eq(1)
            end
          end
          context 'no [currencies pairs] are provided ' do
            it 'USD --> (base currency)
                EUR GBP AUD JPY CAD EGP --> (quote currencies)' do
              input = '1000'
              converter = CurrencyConverter.new(input)
              converter.converter_format
              expect(converter.pairs).to eq(%w[USD EUR GBP AUD JPY CAD EGP])
            end
          end
          context '[currencies pairs] is provided with only one value [v]' do
            it '[v] --> (base currency)
                USD EUR GBP AUD JPY CAD  --> (quote currencies)' do
              input = '1000 SAR'
              converter = CurrencyConverter.new(input)
              converter.converter_format
              expect(converter.pairs).to eq(%w[SAR USD EUR GBP AUD JPY CAD])
            end
            context '[v] ∈ (quote currencies)' do
              it 'should not convert [v] against itself' do
                input = '1000 EUR'
                converter = CurrencyConverter.new(input)
                converter.converter_format
                expect(converter.pairs).to_not eq(%w[EUR USD EUR GBP AUD JPY CAD])
              end
            end
          end
          context '[currencies pairs] is provided with more than one value [ [v1] [v2] [v3] .....]' do
            example '[v1] --> (base currency)
              [v2],[v3]..... -->  (quote currencies)' do
              input = '1000 USD EGP EUR'
              converter = CurrencyConverter.new(input)
              converter.converter_format
              expect(converter.pairs).to eq(%w[USD EGP EUR])
            end
          end
        end
        describe 'different form of v1,v2,v3 belongs to [currencies pairs]' do
          describe 'could be in the form of  currency code, country name or currency name' do
            it "should convert each v1 to it'\s correspond CODE " do
              input = '1000 united-states france egyptian-pound cad'
              converter = CurrencyConverter.new(input)
              converter.converter_format
              expect(converter.pairs).to eq(%w[USD EUR EGP CAD])
            end
          end
        end
        describe " v ∈[currencies pairs] that it can't be interpreted" do
          it 'should be ignored' do
            input = '1000 hgjhgjh USD EGP 15 EUR'
            converter = CurrencyConverter.new(input)
            converter.converter_format
            expect(converter.pairs).to eq(%w[USD EGP EUR])
          end
        end
      end
    end
  end
end
