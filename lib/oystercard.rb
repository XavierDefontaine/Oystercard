class Oystercard
  attr_reader :balance, :entry_station, :journeys
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise "Exceeds maximum card limit of #{MAX_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def tap_in(entry_station="not-a-station")
    raise 'Card is already tapped in' if in_journey?
    raise 'Insufficient Funds' if @balance < MINIMUM_FARE

    @entry_station = entry_station
  end

  def tap_out(exit_station = 'default')
    raise 'Card is already tapped out' unless in_journey?
    deduct(MINIMUM_FARE)

    @exit_station = exit_station
    add_journey
    reset_journey
  end

  private

  def exceeds_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end

  def add_journey
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
  end

  def reset_journey
    @entry_station = nil
    @exit_station = nil
  end

end
