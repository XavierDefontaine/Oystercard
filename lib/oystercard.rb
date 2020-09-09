class Oystercard
  attr_reader :balance, :status, :entry_station
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @status = :TAPPED_OUT

  end

  def top_up(amount)
    raise "Exceeds maximum card limit of #{MAX_LIMIT}" if exceeds_limit?(amount)

    @balance += amount
  end

  def in_journey?
    @status == :TAPPED_IN
  end

  def tap_in(entry_station="not-a-station")
    raise 'Card is already tapped in' if in_journey?
    raise 'Insufficient Funds' if @balance < MINIMUM_FARE

    @status = :TAPPED_IN
    @entry_station = entry_station
  end

  def tap_out
    raise 'Card is already tapped out' unless in_journey?
    deduct(MINIMUM_FARE)
    @status = :TAPPED_OUT
  end

  private

  def exceeds_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end

  def deduct(fare)
    @balance -= fare
  end
  

end
