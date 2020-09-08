require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }

  it 'sets a balance in the card with default value of 0' do
    expect(card.balance).to eq(0)
  end

  describe '#top_up()' do
    # so we know something is passed to the method
    it 'increases the balance of the card by amount' do
      amount = 100
      expect{ card.top_up(amount) }.to change{card.balance}.by(amount)
    end

    it 'returns the updated balance of the card' do
      amount = 100
      expect(card.top_up(amount)).to eq(card.balance)
    end
  end

end