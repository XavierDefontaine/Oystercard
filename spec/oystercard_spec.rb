require 'oystercard'

describe Oystercard do
    it 'sets a balance in the card with default value of 0' do
        card = Oystercard.new
        expect(card.balance).to eq(0)
    end
    
    describe '#top_up()' do # so we know something is passed to the method
      it 'increases the balance of the card by amount' do
        card = Oystercard.new
        expect(card.top_up(100)).to eq(100)
      end
    end


end