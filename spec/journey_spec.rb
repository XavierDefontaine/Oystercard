require 'journey'

describe Journey do
  let(:entry_station) { double 'station' }
  let(:exit_station) { double 'station' }
  subject(:journey) {Journey.new}

  it "has an entry_station" do
    expect(journey.entry_station).to eq nil
  end

  it "has an exit_station" do
    expect(journey.exit_station).to eq nil
  end

  describe '#start(station)' do
    it 'stores an entry station' do
      expect{ journey.start(entry_station) }.to change{ journey.entry_station }.from(nil).to(entry_station)
    end
  end

  describe '#end(station)' do
    it 'stores an exit station' do
      expect{ journey.end(exit_station) }.to change{ journey.exit_station }.from(nil).to(exit_station)
    end

    it 'returns the journey' do
      journey.start(entry_station)
      expect(journey.end(exit_station)).to eq ({ entry_station: entry_station, exit_station: exit_station })
    end
  end


  describe '#in_journey?' do
    it 'returns false if entry_station is nil' do
      expect(journey.in_journey?).to eq false
    end

    it 'returns true if entry_station is not nil' do
      journey.start(entry_station)
      expect(journey.in_journey?).to eq true
    end

  end

  describe "#fare" do
    it "return the minimum fare if journey there is both entry and exit station" do
      journey.start(entry_station)
      journey.end(exit_station)
      expect(journey.fare).to eq Journey::MINIMUM_FARE
    end

    it "return the maximum fare if journey there is an entry OR exit station missing" do
      journey.start(entry_station)
      journey.end
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end

# ##################
#
# it 'updates the card to be not in journey' do
#   card.tap_out
#   expect(card.in_journey?).to eq false
# end
#

#

# it 'returns false if the card status is tapped out' do
#   expect(card.in_journey?).to eq false
# end
# end
#
# end