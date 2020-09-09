require 'journey'
describe Journey do
let(:station) {double station}
subject(:journey) {Journey.new}

it "has an entry_station" do
  expect(journey.entry_station).to eq nil
end

it "has an exit_station" do
  expect(journey.exit_station).to eq nil
end


it 'updates the card to be not in journey' do
  card.tap_out
  expect(card.in_journey?).to eq false
end

it 'updates entry_station to nil' do
  card.tap_out
  expect(card.entry_station).to eq nil
end

describe '#in_journey?' do
it 'returns true if the card status is tapped in' do

end

it 'returns false if the card status is tapped out' do
  expect(card.in_journey?).to eq false
end
end

end