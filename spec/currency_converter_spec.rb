require_relative '../lib/currency_converter.rb'

RSpec.describe CurrencyConverter do
  let(:currency_converter) { CurrencyConverter.new(input) }
  describe 'constant API' do
    it 'can not be accessed outside the class' do
      expect { CurrencyConverter::API }.to raise_error NameError
    end
  end

  describe '#input_interpret' do
    context "invalid user input" do
      context 'more than one amount is provided' do
        it 'should raise an error ' do
          input = '5.1 5 USD EUR'
          expect()
        end
      end
    end
  end
end






end