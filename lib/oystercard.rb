class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0
  MAX_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Exceeds maximum card limit of #{MAX_LIMIT}" if (@balance + amount) > MAX_LIMIT
    @balance += amount
  end

end
