require_relative '../lib/ccbot.rb'

RSpec.describe CCBot do
let(:ccbot) {CCBot.new}
    context 'respond to messages' do
        it'responds to mesgs by saying hello' do
            expect(ccbot.class).to eq(CCBot)
        end
    end
end