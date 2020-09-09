require 'station'
describe Station do
let(:station_name) {"Waterloo"}
subject(:station) {Station.new(station_name, 1)}

it "is an instance of station class" do
  expect(station).to be_an_instance_of(Station)
end

it "has a name" do
  expect(station.name).to eq station_name
end

it "has an attributed zone" do
  expect(station.zone).to eq 1
end


end