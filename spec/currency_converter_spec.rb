require_relative '../lib/currency_converter.rb'

RSpec.describe CurrencyConverter do
    let(:currency_converter){CurrencyConverter.new}
    describe 'constant API' do
        it 'can not be accessed outside the class' do
            expect{CurrencyConverter::API}.to raise_error NameError
            
        end

    end
 
end
