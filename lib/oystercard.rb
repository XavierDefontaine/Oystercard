require 'journey'
class Oystercard
  attr_reader :balance, :journeys, :journey
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MINIMUM_FARE = 1
  

  def initialize(journey_class = Journey, balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @journey = nil
    @journey_class = journey_class
  end

  def top_up(amount)
    raise "Exceeds maximum card limit of #{MAX_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def tap_in(entry_station)
    @journey = @journey_class.new unless @journey
    raise 'Insufficient Funds' if @balance < MINIMUM_FARE

    @journey.start(entry_station)
  end 

  def tap_out(exit_station = 'default')
    ## TODO: add for when card is already in journey
    deduct(MINIMUM_FARE)

    current_journey = @journey.end(exit_station)
    add_journey(current_journey)
    reset_journey
  end

  private

  def exceeds_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def add_journey(current_journey)
    @journeys << current_journey
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
  end

end
