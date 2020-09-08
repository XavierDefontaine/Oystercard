class Oystercard
  attr_reader :balance, :status
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @status = "tapped out"
  end

  def top_up(amount)
    raise "Exceeds maximum card limit of #{MAX_LIMIT}" if exceeds_limit?(amount)
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @status == "tapped in"
  end

  private

  def exceeds_limit?(amount)
    (@balance + amount) > MAX_LIMIT
  end
  

end
