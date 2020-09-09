require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:amount) { 20 }
  let(:fare) { 20 }
  let(:station) {double "station"}
  
  it 'sets status to tapped out by default' do
    expect(card.status).to eq(:TAPPED_OUT)
  end

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

    it "doesn't increase balance if top up would put balance over the maximum limit" do
      amount = Oystercard::MAX_LIMIT * 2
      expect{ card.top_up(amount) rescue nil }.not_to change{ card.balance }
    end
  end

  describe '#in_journey?' do
    it 'returns true if the card status is tapped in' do

    end

    it 'returns false if the card status is tapped out' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#tap_in' do
    context 'when card status is :TAPPED_OUT with balance' do
      before {card.instance_variable_set(:@balance, 5)}

      it 'updates the card status to :TAPPED_IN' do
        card.tap_in
        expect(card.status).to eq(:TAPPED_IN)
      end

      it "stores an entry station as an instance variable" do
        card.tap_in(station)
        expect(card.entry_station).to eq station
      end

    end
    context "when card is :TAPPED_OUT with no balance" do 
      it 'raises an error when tapping in with balance less than minimum' do
        expect {card.tap_in}.to raise_error "Insufficient Funds"
      end
      it "doesn't raise an error when balance == MINIMUM_FARE" do
        card.top_up(Oystercard::MINIMUM_FARE)
        expect {card.tap_in}.not_to raise_error 
      end
    end

    context 'when card status is :TAPPED_IN' do
      before do
        card.instance_variable_set(:@balance, 5)
        card.tap_in # set the card status to :TAPPED_IN
      end
      it 'raises an error that the card is already tapped in' do
        expect{ card.tap_in }.to raise_error('Card is already tapped in')
      end
    end
  end

  describe '#tap_out' do
    context 'when card status is :TAPPED_IN with 5 balance' do
      before do
        card.instance_variable_set(:@balance, 5)
        card.tap_in
      end
      it 'updates the card status to :TAPPED_OUT' do
        
       
        card.tap_out
        expect(card.status).to eq(:TAPPED_OUT)
      end
      it "reduces balance by minimum fare on tap out" do
        expect {card.tap_out}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
      end
    end

    context 'when card status is :TAPPED_OUT' do
      it 'raises an error that the card is already tapped out' do
        expect{ card.tap_out }.to raise_error('Card is already tapped out')
      end
      it 'does not deduct from the balance when "already tapped out raised"' do
        expect {card.tap_out rescue nil}.not_to change{card.balance}
      end
    end
  end

end