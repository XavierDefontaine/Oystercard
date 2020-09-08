require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:amount) { 20 }
  let(:fare) { 20 }

  it 'sets a balance in the card with default value of 0' do
    expect(card.balance).to eq(0)
  end

  describe '#top_up(amount)' do
    # so we know something is passed to the method
    it 'increases the balance of the card by amount' do
      expect{ card.top_up(amount) }.to change{card.balance}.from(card.balance).to(card.balance + amount)
    end

    it 'returns the updated balance of the card' do
      expect(card.top_up(amount)).to eq(card.balance)
    end

    it 'raises an error if amount is above the maximum limit' do
      amount = Oystercard::MAX_LIMIT * 2
      expect{ card.top_up(amount) }.to raise_error("Exceeds maximum card limit of #{Oystercard::MAX_LIMIT}")
    end

    it 'raises an error if the top up would increase the balance over the maximum limit' do
      card.top_up(Oystercard::MAX_LIMIT) # set up test card with a full balance
      expect{ card.top_up(1) }.to raise_error("Exceeds maximum card limit of #{Oystercard::MAX_LIMIT}")
    end
  end

  describe '#deduct(fare)' do
    it 'deducts fare from the balance' do
        expect{ card.deduct(fare) }.to change{card.balance}.from(card.balance).to(card.balance - fare)
    end

  end
  

end