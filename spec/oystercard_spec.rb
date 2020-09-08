require 'oystercard'

describe Oystercard do
    it 'sets a balance in the card with default value of 0' do
        card = Oystercard.new
        expect(card.balance).to eq(0)
    end

end